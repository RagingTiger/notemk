#!/usr/bin/env bash

# globals
dt="`date '+%m.%d.%y'`"
note_str=".notes"

# functions
edit_file() {
  nano $1
}

write_hdr() {
  # get day, month, year
  day="`date '+%d'`"
  DAY="`date '+%A'`"
  MONTH="`date '+%B'`"
  YEAR="`date '+%Y'`"

  # write header
  echo "" >> "$1"
  echo "Entry: $DAY, $MONTH $day, $YEAR" >> "$1"
  echo "  -" >> "$1"
}

make_dir() {
  # check if .note dir exists
  ndir="$1/$note_str/"
  if [ -d "$ndir" ]; then
    return 1
  elif [[ $PWD == *$note_str* ]]; then
    return 0
  else
    mkdir "$ndir"
    return 1
  fi
}

check_pdir() {
  # get basename of directory arg
  pwdb=$(basename $1)

  # check for project_dir variable
  pdir=
  if [ $PROJECT_DIR ] && [[ $PWD == *$PROJECT_DIR* ]] &&
     [ $pwdb != $PROJECT_DIR ]; then
    echo "$PROJECT_DIR."
  else
    echo ""
  fi
}

get_dir() {
  # check name
  base="`basename $1`"
  if [[ *$base* == $note_str ]]; then
    dir="`dirname $1`"
    get_dir "$dir"

  elif [[ $base =~ ".." ]]; then
    :

  else
    echo "$base"
  fi
}

exists() {
  # exists
  echo "File \"$1\" already exists"

  # get answer for editing
  answer=
  echo -n "Do you want to edit it?[y|n]: "
  read answer

  # check answer
  case $answer in
    "y") edit_file "$1";;
    "yes") edit_file "$1";;
  esac
}

make_note() {
  # get project dir
  pdir=$( check_pdir $2 )

  # check if .note dir exists
  if make_dir $2; then
    echo "No nested \".notes\" directories allowed :)"
    return 1
  fi

  # note name
  note="$2/.notes/$pdir$1.$dt.txt"

  # check if note exists
  if [ -e "$note" ]; then
    # exists
    exists $note

  else
    # create new note
    touch "$note"

    # write header
    write_hdr $note

    # edit file
    edit_file $note

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
  main "$PWD"

else
  # check args
  main "$1"
fi
