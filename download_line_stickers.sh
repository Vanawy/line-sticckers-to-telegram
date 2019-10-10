#!/bin/bash

while getopts i:n: option
do
case "${option}"
in
i) ID=${OPTARG};;
n) NAME=${OPTARG};;
esac
done
if !([ -z "$ID" ]) || !([ -z "$NAME" ])
then
	mkdir "$NAME" 
	echo "Directory $NAME/ created"
	wget http://dl.stickershop.line.naver.jp/products/0/0/1/$ID/iphone/stickers@2x.zip -O "$NAME/source.zip"
	unzip "$NAME/source.zip" -d "$NAME" 
	rm "$NAME"/*_key*
	echo "Files downloaded and extracted!"
	echo "Image processing..."
	cd "$NAME"
	mkdir result
	for f in *.png; do
		convert ./"$f" -background none -gravity center -extent 512x512 ./result/$f
	done 
	echo "Done!"
else
	echo "-i {ID} -n {NAME} not set"
fi