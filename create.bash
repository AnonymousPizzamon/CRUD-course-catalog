#!/usr/bin/env bash
set -u

#user can set DATA_DIR, if unset it will fall back on ./data
DATA_DIR="${DATA_DIR:-./data}"
LOG_FILE="${LOG_FILE:-$DATA_DIR/queries.log}"
mkdir -p "$DATA_DIR"
touch "$LOG_FILE"

#IFS is being set to nothing so the whole line is read as one field from the piped input
IFS= read -r dept_code   || exit 0
IFS= read -r dept_name   || exit 0
IFS= read -r num_raw     || exit 0
IFS= read -r course_name || exit 0
IFS= read -r sched       || exit 0
IFS= read -r start       || exit 0
IFS= read -r end         || exit 0
IFS= read -r hours       || exit 0
IFS= read -r size        || exit 0

dept_uc="${dept_code^^}" #normalize to uppercase
printf -v num "%04d" "$num_raw"  # -v stores it in variable instead of printing
file="$DATA_DIR/${dept_uc}${num}.crs"

if [[ -e "$file" ]]; then
  echo "ERROR: course already exists"
  exit 0
fi

#piping output to file
{
  printf "%s %s\n" "$dept_uc" "$dept_name"
  printf "%s\n" "$course_name"
  printf "%s %s %s\n" "$sched" "$start" "$end"
  printf "%s\n" "$hours"
  printf "%s\n" "$size"
} >"$file"

#adds to log file with timestamp, action, and course info
echo "[$(date)] CREATED: $dept_uc $num $course_name" >>"$LOG_FILE"
# $() needed for command substitution
