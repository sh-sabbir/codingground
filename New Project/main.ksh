#! /bin/bash

ORIG_W=$(cat ORIG_RES | cut -d'x' -f1)
ORIG_H=$(cat ORIG_RES | cut -d'x' -f2)
PORT_W=$(cat PORT_RES | cut -d'x' -f1)
PORT_H=$(cat PORT_RES | cut -d'x' -f2)

IMG_FOLDERS=$( ls -d images/)
for folder in $IMG_FOLDERS
do
	cd $folder
	for img in *.png
	do
		Width=$( exiftool "$img" -p "$ImageWidth" )
		Height=$( exiftool "$img" -p "$ImageWidth" )
		new_width=$(perl -e "print int(($Width / $ORIG_W * $PORT_W ) + 0.5)")
		new_height=$(perl -e "print int(($Height / $ORIG_H * $PORT_H ) + 0.5)")
		echo "convert ${folder}${img} from ${Width}x${Height} to ${new_width}x${new_height}"
		convert ${img} -resize ${new_width}x${new_height}! png32:${img}1
		mv ${img}1 ${img}
	done
	cd ..
done

