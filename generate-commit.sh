#!/bin/sh

FAIL_OR_SUCCESS=$1

NUMBER_OF_ITERATIONS=$2

if [ "$FAIL_OR_SUCCESS" != "fail" ] && [ "$FAIL_OR_SUCCESS" != "success" ]; then
  echo "$FAIL_OR_SUCCESS did not equal fail or success, cancelling!"
  exit 1
fi

if [ "$NUMBER_OF_ITERATIONS" = "" ] || [ "$NUMBER_OF_ITERATIONS" -le 1 ]; then
  echo "$NUMBER_OF_ITERATIONS must be greater than 1!"
  exit 1
fi

counter=0

while [ $counter -le $NUMBER_OF_ITERATIONS ] 
do

  FILE=$(sed -e "s/\$1/$counter/g" $FAIL_OR_SUCCESS-test.sh) 
  echo "$FILE" > ./test-condition.sh

  git add -- .
  git commit -m"$FAIL_OR_SUCCESS number $counter"

  ((counter++))
done

