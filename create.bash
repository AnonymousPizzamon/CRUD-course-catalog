#!/usr/bin/env bash
set -u

#user can set DATA_DIR, if unset it will fall back on ./data
DATA_DIR="${DATA_DIR:-./data}"
LOG_FILE="${LOG_FILE:-$DATA_DIR/queries.log}"
mkdir -p "$DATA_DIR"
touch "$LOG_FILE"

echo "***** Create New Course Record  ******"

echo "Enter department code (e.g. CS):"
read -r dept_code

echo "Enter department name (e.g. Computer Science):"
read -r dept_name

echo "Enter course number (e.g. 2105):"
read -r num_raw

echo "Enter course name (e.g. Systems Programming):"
read -r course_name

echo "Enter meeting days (e.g. MON/WED):"
read -r sched

echo "Enter start date (YYYY-MM-DD):"
read -r start

echo "Enter end date (YYYY-MM-DD):"
read -r end

echo "Enter credit hours (e.g. 3):"
read -r hours

echo "Enter class size (e.g. 40):"
read -r size


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
echo "Created: $dept_uc $num- $course_name"
