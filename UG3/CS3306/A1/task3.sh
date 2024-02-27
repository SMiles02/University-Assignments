#!/bin/sh

# S/N: 121513663

# Find all files along with their sizes
all_files=$(find . -type f -exec du -h {} +)

# Sort the file list in reverse order, using a size-based comparator
sorted_files=$(echo "${all_files}" | sort -rh)

# Get the largest file
largest_file=$(echo "${sorted_files}" | head -n 1)

# Get the file name & size in KBs
file_name=$(echo "${largest_file}" | awk '{print $2}')
file_size=$(echo "${largest_file}" | awk '{print $1}')

# Print the results
echo "The largest file is: ${file_name} with size ${file_size}"