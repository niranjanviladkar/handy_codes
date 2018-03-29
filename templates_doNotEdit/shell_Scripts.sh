# to check continuous mem usage
while [[ 1 ]]; do free -h | tail -n2 | head -n1; sleep 1; done
