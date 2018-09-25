#!/bin/sh

START=$1
END=$(git rev-parse HEAD)

./test-condition.sh
RESULT=$?
if [ $RESULT -eq 0 ]; then
  echo "The current revision is working, expected it to be failing!"
  exit 1
fi

git checkout $START
./test-condition.sh
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "The start revision is failing expected it to be good!"
  exit 1
fi

git checkout $END
git bisect start
git bisect bad
git checkout $START
git bisect good

while true; 
do
  ./test-condition.sh
  RESULT=$?
  if [ $RESULT -eq 0 ]; then
    BISECT_RESULT=$(git bisect good)
  else 
    BISECT_RESULT=$(git bisect bad)
  fi
  
  HAS_FOUND_IT=$(echo $BISECT_RESULT | grep "is the first bad commit")
  if [ "$HAS_FOUND_IT" != "" ]; then
    echo "The guilty commit has been found!!!"
    echo $BISECT_RESULT
    exit 0
  fi
done
