#!/bin/bash

ask_to_delete() {
	echo "Delete file(y/n)?"
	echo "$1"
}

need_to_delete() {

	ask_to_delete "$1"

	read -p "Input (y/n):" answer < /dev/tty

	if echo "$answer" | grep "^y"; then
		return 0
	else 
		return 1
	fi
}

is_empty() {
	if [ -s "$1" ]; then
		return 1
	else
	    return 0
	fi
}

delete() {
	rm -vr "$1"
}

related_files="related_files.txt"
mdfind -name "$1" > "$related_files"

if is_empty "$related_files"; then
	echo "No '$1' application files on your computer" 
	delete "$related_files"
    exit 0
fi

cat "$related_files" | while read filename; do
	if need_to_delete "$filename"; then
		delete "$filename"
	fi
done

delete "$related_files"
exit 0
