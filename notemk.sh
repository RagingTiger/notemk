#!/usr/bin/env bash

# functions
make_note() {
  # get date
  dt="`date '+%m.%d.%y'`"

  # check for project_dir variable
  pdir=
  if [ $PROJECT_DIR ]; then
    pdir="$PROJECT_DIR."
  else
    pdir=""
  fi

  # note name
  note="$2/$pdir$1.$dt.txt"

  # check if note exists
  if [ -e "$note" ]; then
    echo "File \"$note\" already exists"

  else
    # create new note
    touch "$note"

    # get day, month, year
    day="`date '+%d'`"
    DAY="`date '+%A'`"
    MONTH="`date '+%B'`"
    YEAR="`date '+%Y'`"

    # write header
    echo "Entry: $DAY, $MONTH $day, $YEAR" >> "$note"
  fi
}

get_dir() {
  # check name
  base="`basename $1`"
  note_str="note"
  if [[ $base =~ $note_str ]]; then
    dir="`dirname $1`"
    get_dir "$dir"
  else
    echo "$base"
  fi
}

main() {
  # get dir for note name
  name=$( get_dir "$1" )

  # make note
  make_note "$name" "$1"

}


# run main
if [ -z "$1" ]; then
  # execute without args
  dir="$PWD"
  main "$dir"

else
  # check args
  case "$1" in
    "path") ;;
    "p") ;;
    "ed") ;;
    "e") ;;
  esac
fi
