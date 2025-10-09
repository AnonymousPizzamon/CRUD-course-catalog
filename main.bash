#!/usr/bin/env bash

#exits if there's undefined variable
set -u

DATA_DIR="${DATA_DIR:-./data}"
LOG_FILE="${LOG_FILE:-$DATA_DIR/queries.log}"
mkdir -p "$DATA_DIR"
touch "$LOG_FILE"

while true; do
  echo "Enter one of the following actions or press CTRL-D to exit."
  echo "C - create a new course record"
  echo "R - read an existing course record"
  echo "U - update an existing course record"
  echo "D - delete an existing course record"
  echo "E - update enrolled student count of existing course"
  echo "T - show total course count"

  #reads line of input (safe even if there's accidental '\'), then stores in "action" variable.
  if ! read -r action; then exit 0; fi 
  
  case "${action^^}" in
    C) #create option
    echo "Enter department code:";   read -r dept_code
    echo "Enter department name:";   read -r dept_name
    echo "Enter course number:";     read -r num_raw
    echo "Enter course name:";       read -r course_name
    echo "Enter meeting days/times:"; read -r sched
    echo "Enter start date (YYYY-MM-DD):"; read -r start
    echo "Enter end date (YYYY-MM-DD):";   read -r end
    echo "Enter credit hours:";       read -r hours
    echo "Enter class size:";         read -r size

    #pipes values to create.bash, create.bash will then have to read them in
    printf "%s\n" \
      "$dept_code" "$dept_name" "$num_raw" "$course_name" \
      "$sched" "$start" "$end" "$hours" "$size" | ./create.bash
    ;;
    R) ./read.bash ;;
    U) ./update.bash ;;
    D) ./delete.bash ;;
    E) ./enroll.bash ;;
    T) ./total.bash ;;
    *) echo "ERROR: invalid option" ;;
  esac
done
