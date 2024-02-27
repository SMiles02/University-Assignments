#!/bin/sh

# S/N: 121513663

# Check if the number of arguments is nonzero
if [ $# -eq 0 ]
then
    echo "Error: Please provide a file as an argument"
    exit 1
fi

# Check if the file corresponding to the provided argument exists
file_path="${1}"
if [ ! -f "${file_path}" ]
then
    echo "Error: '${file_path}' not found."
    exit 1
fi

awk -F: '{
    # extract information from the input line
    student_id = $1
    first_name = $2
    last_name = $3
    marks = $4

    # average mark = (sum of marks) / (count of marked subjects)
    sum = 0
    subject_count = 0
    split(marks, marks_array, " ")
    for (i in marks_array) {
      sum += i
      subject_count += 1
    }
    
    if (subject_count == 0) {
        average = 0
    }
    else {
        average = sum / subject_count
    }

    # print the student summary
    printf "Student ID: %s\n", student_id
    printf "Full Name: %s %s\n", first_name, last_name
    printf "Marks: %s\n", marks
    printf "Average: %.2f\n", average
    print "----------------------"
}' "${file_path}"