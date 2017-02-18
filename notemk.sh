#!/usr/bin/env bash

# functions
make_dir() {
  # check if .note dir exists
  ndir="$1/.notes/"
  if [ -d "$ndir" ]; then
    :
  else
    mkdir "$ndir"
  fi
}

make_note() {
  # get date
  dt="`date '+%m.%d.%y'`"

  # check for project_dir variable
  pdir=
  if [ $PROJECT_DIR ] && [[ $PROJEC_DIR =~ $PWD ]]; then
    pdir="$PROJECT_DIR."
  else
    pdir=""
  fi

  # check if .note dir exists
  make_dir $2

  # note name
  note="$2/.notes/$pdir$1.$dt.txt"

  # check if note exists
  if [ -e "$note" ]; then
    # exists
    echo "File \"$note\" already exists"

    # get answer for editing
    answer=
    echo -n "Do you want to edit it?[y|n]: "
    read answer

    # check answer
    case $answer in
      "y") nano "$note";;
      "yes") nano "$note";;
    esac

  else
    # create new note
    touch "$note"

    # get day, month, year
    day="`date '+%d'`"
    DAY="`date '+%A'`"
    MONTH="`date '+%B'`"
    YEAR="`date '+%Y'`"

    # write header
    echo "" >> "$note"
    echo "Entry: $DAY, $MONTH $day, $YEAR" >> "$note"
    echo "  -" >> "$note"

    # if arg 3
    case $3 in
      "ed")
        # open for writing
        nano $note
        ;;
    esac
  fi
}

get_dir() {
  # check name
  base="`basename $1`"
  note_str=".notes"
  if [[ $base =~ $note_str ]]; then
    dir="`dirname $1`"
    get_dir "$dir"

  elif [[ $base =~ ".." ]]; then
    :

  else
    echo "$base"
  fi
}

main() {
  # get dir for note name
  name=$( get_dir "$1" )

  # make note
  make_note "$name" "$1" "ed"

}


# run main
if [ -z "$1" ]; then
  # execute without args
  dir="$PWD"
  main "$dir"

else
  # check args
  main "$1"
fi
