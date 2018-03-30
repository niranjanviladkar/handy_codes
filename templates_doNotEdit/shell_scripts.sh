# to check continuous mem usage
while [[ 1 ]]; do free -h | tail -n2 | head -n1; sleep 1; done

# Go to a top level directory - parent for many git repos
# run below code to get all repos updated in one go.
for dir in `ls -1`; do echo -n "$dir "; cd $dir; git pull; cd ..; done
