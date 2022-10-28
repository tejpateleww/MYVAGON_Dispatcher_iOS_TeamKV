#!/bin/sh

OLDNAME=$1
NEWNAME=$2

export LC_CTYPE=C
export LANG=C
find . -type f ! -path ".*/.*" -exec sed -i '' -e "s/${OLDNAME}/${NEWNAME}/g" {} +

mv "${OLDNAME}.xcodeproj" "${NEWNAME}.xcodeproj"
mv "${OLDNAME}" "${NEWNAME}"
