#!/bin/bash

for dir in *; do
	if [ -d "$dir" ]; then
		cd "$dir"
		for next_dir in *; do
			if [ "$next_dir" = ci-dev-drv ]; then
				cd ci-dev-drv
				# loop through each file in the directory
				for file in *; do
					# check if the file is a regular file
					if [ -f "$file" ]; then
						# use vim to insert "stable_media: True" into the 4th line of the file
						vim -c "5i|stable_media: True" -c "wq" "$file"
					fi
				done
				cd ..
			fi
		done
		cd ..
	fi
done
