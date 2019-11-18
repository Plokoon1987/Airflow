#! /bin/bash

while test $# -gt 0; do
  case "$1" in
    -u|--username)
      shift
      USER=$1
      echo $USER
      shift
    ;;
    -p|--password)
      shift
      PASSWORD=$1
      echo $PASSWORD
      shift
    ;;
    -d|--database)
      shift
      DATABASE=$1
      echo $DATABASE
      shift
    ;;
    *)
      break
    ;;
  esac
done

psql postgres -c "create role $USER login password '$PASSWORD'"
createdb --encoding=UTF8 --owner=$USER $DATABASE
