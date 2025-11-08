#!/usr/bin/env bash
set -u

DATA_DIR="${DATA_DIR:-./data}"

echo "Enter a department code and course number:"
if ! read -r dept num_raw; then exit 0; fi

dept_uc="${dept^^}"
printf -v num "%04d" "$num_raw"
file="$DATA_DIR/${dept_uc}${num}.crs"

if [[ ! -f "$file" ]]; then
  echo "ERROR: course not found"
  exit 0
fi

#read input from set file path. No splits, read line up to \n (default for read), store in variable.
{
  IFS= read -r line1
  IFS= read -r course_name
  IFS= read -r sched_line
  IFS= read -r hours
  IFS= read -r size
} <"$file"

dept_code="${line1%% *}" #keeps first word
dept_name="${line1#* }" #keeps rest after first space
read -r sched start end <<<"$sched_line" #supports day and 2 dates, seperates by spaces. <<< is for single string.

#see if it worked
echo "Course department: $dept_code $dept_name"
echo "Course number: $num"
echo "Course name: $course_name"
echo "Scheduled days: $sched"
echo "Course start: $start"
echo "Course end: $end"
echo "Credit hours: $hours"
echo "Enrolled Students: $size"

