#!/bin/bash
cnt=0

pushd $(dirname "$0")/bundle &&
# cd ~/.vim/bundle &&
for d in *; do
  if [ -d $d/.git ]; then
    echo "Updating $d"
    cd $d && git pull &
    # Prevent having too many subprocesses
    (( (cnt += 1) % 16 == 0 )) && wait
  fi
done
wait

popd
