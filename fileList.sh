#!/usr/bin/env bash

fileList_darwin () {
  ERRMSG='usage: sh fileList.sh [DIRECTORY]'

  if [ $# == 0 ]
  then
    echo "$ERRMSG"
    exit 1
  elif [ -d $1 ]
  then
    for i in $1/*
    do
      if [ -f "$i" ]
      then
        echo "File: $(basename "$i")"
        echo "   Size: $(stat -f%z "$i") bytes"
        echo "   Permissions: $(stat -f%Sp "$i")"
        echo "   Last modified: $(stat -f%Sm "$i")"
      elif [ -d "$i" ]
      then
        echo "Directory: $(basename "$i")"
      fi
    done
  else
    echo "Error: '$1' is an invalid directory"
    exit 1
  fi
}

fileList_linux () {
  ERRMSG='usage: sh fileList.sh [DIRECTORY]'

  if [ $# == 0 ]
  then
    echo "$ERRMSG"
    exit 1
  elif [ -d $1 ]
  then
    for i in /$1/*
    do
      if [ -f "$i" ]
      then
        echo "File: $(basename "$i")"
        echo "   Size: $(stat -c%s "$i") bytes"
        echo "   Permissions: $(stat -c%A "$i")"
        echo "   Last modified: $(stat -c%y "$i")"
      elif [ -d "$i" ]
      then
        echo "Directory: $(basename "$i")"
      fi
    done
  else
    echo "Error: '$1' is an invalid directory"
    exit 1
  fi
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        fileList_linux $1;
elif [[ "$OSTYPE" == "darwin"* ]]; then
        fileList_darwin $1;
else
        echo "This operating system is not supported!"
fi