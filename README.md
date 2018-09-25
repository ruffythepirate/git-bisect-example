# Introduction

This is a small shell script that tries to automate the `git bisect` work to find a problematic commit. The idea is that you create a shell script that runs the test you want to try out. This can be a simple command like `mvn test`, or something that is more composite like 
```
rm -rf node_modules
npm i
grunt default
npm run test
```

The point is that you contain this logic in a script called `test-condition`. You then run the `run-git-bisect.sh` script with the git sha of a first commit you know is correct. It will then perform a git bisect between the current commit and he one you know is working. Once it has found the proper commit it will exit out and print the git bisect output informing which commit is the guilty one.

Regarding the other files in the repo: They were all created to test the idea. If you look in the repo you will see multiple commits that are either `success` or `fail`, these can be played around with when testing he `run-git-bisect.sh` command. Another problem is that using `run-git-bisect.sh` will create problems because the file is removed when checking out older revisions. You can get around this by copying the file to something called `run-git-bisect-2.sh` and use this script instead. Because it is not added to the repo, the file will not be removed when checking out old revisions.

The idea is that you copy the `run-git-bisect.sh` script to the git repo where you want to test your condition and this way finds out where the issue is.
