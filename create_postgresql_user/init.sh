#! /bin/bash

while test $# -gt 0; do
  case "$1" in
    -u|--username)
      shift
      USER=$1
      shift
    ;;
    -p|--password)
      shift
      PASSWORD=$1
      shift
    ;;
    -d|--database)
      shift
      DATABASE=$1
      shift
    ;;
    *)
      break
    ;;
  esac
done

psql postgres -c "create role $USER login password '$PASSWORD'"
createdb --encoding=UTF8 --owner=$USER $DATABASE
