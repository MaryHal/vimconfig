#!/bin/bash

VIM_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
pushd ${VIM_DIR}/bundle &&

find . -maxdepth 1 -type d -exec sh -c '(cd {} && pwd && git pull)' ';'

# cnt=0
# cd ~/.vim/bundle &&
# for d in *; do
#   if [ -d $d/.git ]; then
#     echo "Updating $d"
#     cd $d && git pull &
#     # Prevent having too many subprocesses
#     (( (cnt += 1) % 16 == 0 )) && wait
#   fi
# done
# wait

popd
