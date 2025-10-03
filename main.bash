#!/usr/bin/env bash
set -u

DATA_DIR="${DATA_DIR:-./data}"
LOG_FILE="$DATA_DIR/queries.log"
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
    C) ./create.bash ;;
    R) ./read.bash ;;
    U) ./update.bash ;;
    D) ./delete.bash ;;
    E) ./enroll.bash ;;
    T) ./total.bash ;;
    *) echo "ERROR: invalid option" ;;
  esac
done
