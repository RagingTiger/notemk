#!/usr/bin/env bash

# globals: day, month, year
note_str=".notes"
dayname="$( date '+%A' )"
daynum=$( date '+%d' )
monthname="$( date '+%B' )"
monthnum="$( date '+%m' )"
year="$( date '+%Y' )"

# final global: date string
dt="$monthnum.$daynum.$year"

# functions
edit_file() {
  nano $1
}

write_hdr() {
  # write header
  echo "" >> "$1"
  echo "Entry: $dayname, $monthname $daynum, $year" >> "$1"
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
    edit_file $note

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
