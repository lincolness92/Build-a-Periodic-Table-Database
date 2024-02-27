#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit 0
fi
ARG=$1

MAIN() {
  i=0
  ELINFO=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) ORDER BY atomic_number")
  IFS='|'
  echo "$ELINFO" | while read TYPE_ID AN SYMBOL NAME AT_MASS MELT BOILING TYPE
  do
    if [[ $ARG == $AN || $ARG == $SYMBOL || $ARG == $NAME ]]
    then
      echo "The element with atomic number $AN is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AT_MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOILING celsius."
      break
    fi
    let i++
    if [[ $i == 10 ]]
    then
      echo "I could not find that element in the database."
    fi
  done
}

MAIN $ARG