#!/bin/bash

cat << EOF
mp4-to-mp3.sh [GO]
  Find videos (mp4 webm m4a avi) recursively in directories.
  Extract the sound part in corresponding mp3 files.
  Move original files to /tmp for later delete, backup...
Launch "mp4-to-mp3 GO" if you understand that files may move.
EOF

[[ "$1" == "GO" ]] || exit

for EXT in mp4 webm m4a avi; do
  echo "Processing $EXT files"
  find . \
    -name "*.$EXT" \
    -exec basename {} ".$EXT" \; \
    -exec sh -c 'ffmpeg -loglevel error -i "$0" "${0%.$1}".mp3' {} "$EXT" \; \
    -exec sh -c '[ -f "${0%.$1}.mp3" ] && mv "$0" /tmp' {} "$EXT" \;
done
