#!/bin/sh

# S/N: 121513663

# Placeholder for input
dir_name=dummy

# Prompt and read input
echo "Enter a directory:"
read dir_name

# Keep running until "q" provided
while [ "$dir_name" != "q" ]
do
	# Check if directory exists
	if [ ! -d "${dir_name}" ]
	then
		echo "Directory not found."

	# Check to make sure directory is not empty
	elif [ "$(ls -A $dir_name)" ]
	then
		# Check for files matching perm codes
		a=(`find $dir_name/* -perm -100 | wc -l`)
		b=(`find $dir_name/* -perm -200 | wc -l`)
		c=(`find $dir_name/* -perm -400 | wc -l`)
		echo $a $b $c

	else
		echo "Directory is empty!"
	fi

	echo "Enter a directory:"
	read dir_name

done