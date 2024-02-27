#!/bin/sh

set -e
set -x

HERE=${PWD}
EXAMPLE=${HERE}/example
PROJECT=project
SHARED=shared
LOCAL=local
ANN=ann
BOB=bob
EVE=eve
SUNEET=suneet
REPO=${EXAMPLE}/${ANN}/${SHARED}/${PROJECT}

rm -rf ${EXAMPLE}

ann_local( ) {
    cd ${EXAMPLE}/${ANN}/${LOCAL}
    sh -c "$1"
}

ann_shared( ) {
    cd ${REPO}
    sh -c "$1"
}

ann_project( ) {
    cd ${EXAMPLE}/${ANN}/${LOCAL}/${PROJECT}
    sh -c "$1"
}

bob_project( ) {
    cd ${EXAMPLE}/${BOB}/${LOCAL}/${PROJECT}
    sh -c "$1"
}

eve_project( ) {
    cd ${EXAMPLE}/${EVE}/${LOCAL}/${PROJECT}
    sh -c "$1"
}

suneet_project( ) {
    cd ${EXAMPLE}/${SUNEET}/${LOCAL}/${PROJECT}
    sh -c "$1"
}

bob_local( ) {
    cd ${EXAMPLE}/${BOB}/${LOCAL}
    sh -c "$1"
}

eve_local( ) {
    cd ${EXAMPLE}/${EVE}/${LOCAL}
    sh -c "$1"
}

suneet_local( ) {
    cd ${EXAMPLE}/${SUNEET}/${LOCAL}
    sh -c "$1"
}

create_bare_repository( ) {
    mkdir ${REPO} -p

    for USR in ${ANN} ${BOB} ${EVE} ${SUNEET}; do
        mkdir ${EXAMPLE}/${USR}/${LOCAL} -p
    done
    ann_shared 'git init --bare --shared'
}

Ann_local_git_repo(){
    ann_local   "mkdir ${PROJECT}"
    ann_project 'git init'
}

Ann_config(){
	ann_project 'git config --local user.name Ann'
	ann_project 'git config --local user.email 11111@CS3306.ucc'
}

Bob_config(){
	ann_project 'git config --local user.name Bob'
	ann_project 'git config --local user.email 22222@CS3306.ucc'
}

Eve_config(){
	ann_project 'git config --local user.name Eve'
	ann_project 'git config --local user.email 33333@CS3306.ucc'
}

Suneet_config(){
	ann_project 'git config --local user.name Suneet'
	ann_project 'git config --local user.email 121513663@CS3306.ucc'
}

populate_bare_repository( ) {
    ann_project 'cat > ProjectDetails.txt <<EOF
This is a project that implements a calculator.

Tasks:
Ann: Adder class and calculator.py script 
Bob: Multiplier class
Eve: Subtractor class
Suneet: examine and merge
EOF'
    ann_project "git add ProjectDetails.txt"
    ann_project "git commit -am 'Initial commit'"
    ann_project "git remote add origin file://${REPO}"
    ann_project 'git push --set-upstream origin master'
}

clone_repository( ) {
    bob_local   "git clone ${REPO}"
    eve_local   "git clone ${REPO}"
    suneet_local   "git clone ${REPO}"
}

local_git_config( ) {
	bob_project 'git config --local user.name Bob'
	bob_project 'git config --local user.email 22222@CS3306.ucc'
	eve_project 'git config --local user.name Eve'
	eve_project 'git config --local user.email 33333@CS3306.ucc'
	suneet_project 'git config --local user.name Suneet'
	suneet_project 'git config --local user.email 121513663@umail.ucc.ie'
}

create_adder_branch( ) {
    # Git credentials
    Ann_config
    # Create a new local branch named Adder
    ann_project "git checkout -b Adder"
    # Write Adder class to adder.py
    ann_project 'cat > adder.py <<EOF
class Adder:
    __result: float = None

    def add(self, val1: float | int, val2: float | int):
        self.__result = val1 + val2

    def display(self):
        if self.__result:
            print(f"Adder output: {self.__result}")
        else:
            print(f"No current adder output")
'
    # Adds the adder.py file to the Git staging area
    ann_project "git add adder.py"
    ann_project "git commit -m 'Added adder.py'"
    ann_project "git push -u origin Adder"
}

create_subtractor_branch( ) {
    # Git credentials
    Eve_config
    # Create a new local branch named Subtractor
    eve_project "git checkout -b Subtractor"
    # Write Subtractor class to subtractor.py
    eve_project 'cat > subtractor.py <<EOF
class Subtractor:
    __result: float = None

    def subtract(self, val1: float | int, val2: float | int):
        self.__result = val1 - val2

    def display(self):
        if self.__result:
            print(f"Subtractor output: {self.__result}")
        else:
            print(f"No current subtractor output")
'
    # Adds the subtractor.py file to the Git staging area
    eve_project "git add subtractor.py"
    eve_project "git commit -m 'Added subtractor.py'"
    eve_project "git push -u origin Subtractor"
}

create_multiplier_branch( ) {
    # Git credentials
    Bob_config
    # Create a new local branch named Multiplier
    bob_project "git checkout -b Multiplier"
    # Write Multiplier class to multiplier.py
    bob_project 'cat > multiplier.py <<EOF
class Multiplier:
    __result: float = None

    def multiply(self, val1: float | int, val2: float | int):
        self.__result = val1 * val2

    def display(self):
        if self.__result:
            print(f"Multiplier output: {self.__result}")
        else:
            print(f"No current multiplier output")
'
    # Adds the multiplier.py file to the Git staging area
    bob_project "git add multiplier.py"
    bob_project "git commit -m 'Added multiplier.py'"
    bob_project "git push -u origin Multiplier"
}

create_branches( ) {
    create_adder_branch
    create_subtractor_branch
    create_multiplier_branch
}

branch_merge( ) {
    # Fetch the latest changes from the remote repository for the Subtractor and Multiplier branches
    ann_project "git fetch origin Subtractor"
    ann_project "git fetch origin Multiplier"

    # Create a new local branch named Calculator
    ann_project "git checkout -b Calculator"

    # Merge changes from the Subtractor and Multiplier branches into the new Calculator branch
    ann_project "git merge origin/Subtractor -m 'Merges subtractor branch with calculator branch, adding subtraction functionality'"
    ann_project "git merge origin/Multiplier -m 'Merges multiplier branch with calculator branch, adding multiplication functionality'"
}

implement_calculator_script( ) {
    # Switch to the Calculator branch
    ann_project "git checkout Calculator"

    # Ann implements the calculator.py script with verification calculations
    ann_project 'cat > calculator.py <<EOF
from adder import Adder
from subtractor import Subtractor
from multiplier import Multiplier

calculator_adder = Adder()
calculator_adder.add(15, 5)
calculator_adder.display()

calculator_subtractor = Subtractor()
calculator_subtractor.subtract(15, 5)
calculator_subtractor.display()

calculator_multiplier = Multiplier()
calculator_multiplier.multiply(4, 3)
calculator_multiplier.display()
'

    # Adds the calculator.py file to the Git staging area
    ann_project "git add calculator.py"

    # Commit the changes & push the changes to the remote repository on the Calculator branch
    ann_project 'git commit -a -m "Added calculator.py with accompanying verification calculations" -m "Created calculator.py file which implements adder, subtractor and multiplier to compute various provided sums."'
    ann_project "git push -u origin Calculator"
}

code_review( ) {
    # Fetch the latest changes from the remote repository for the Calculator branch
    suneet_project "git fetch origin Calculator"
    
    # Switch to the Calculator branch to review the code
    suneet_project "git checkout Calculator"

    # Suneet reviews the code for the Adder, Subtractor, Multiplier, and Calculator scripts one by one
    suneet_project "cat adder.py"
    suneet_project "cat subtractor.py"
    suneet_project "cat multiplier.py"
    suneet_project "cat calculator.py"

    # Switch back to the master branch
    suneet_project "git checkout master"

    # Merge the Calculator branch with master
    suneet_project "git merge Calculator"

    # Push the changes to the master branch in the remote repository
    suneet_project "git push origin master"
}

concluding_remark( ) {
    # Append a line to ProjectDetails.txt indicating the successful completion of the project
    suneet_project 'echo "Project completed successfully!" >> ProjectDetails.txt'

    # Add ProjectDetails.txt to the Git staging area
    suneet_project 'git add ProjectDetails.txt'

    # Commit the changes & push the changes to the master branch in the remote repository
    suneet_project 'git commit -a -m "Add concluding remark to ProjectDetails.txt" -m "Appended line to file, indicating that the project has been successfully completed."'
}

push_master( ) {
    suneet_project 'git push origin master'
}

team_origin_fetch( ) {
    # Iterate over each team member (Ann, Bob, Eve, Suneet)
    for USR in ${ANN} ${BOB} ${EVE} ${SUNEET}; do
        # Change directory to the local project repository of the current team member
        cd ${EXAMPLE}/${USR}/${LOCAL}/${PROJECT}

        # Switch to the master branch to ensure working with the latest changes
        git checkout master

        # Pull the latest changes from origin, with pruning
        git pull --prune origin master

        # Delete local development branches
        git branch | grep -v "master" | xargs -r git branch -D
    done
}

final_inspection( ) {
    ann_project 'git log --oneline --graph'
    suneet_project 'git log --oneline --graph'
}


# Ann sets up shared repository.
create_bare_repository

# Ann sets up local git repository.
Ann_local_git_repo

# Ann performs local configuration
Ann_config

# Ann populates the bare repository
populate_bare_repository

# Others clone the shared repository
clone_repository

# Bob, Eve and Suneet perform local git configuration
local_git_config

# Creation of adder, subtraction & multiplier branch
create_branches

# # Ann fetches the subtractor and Multiplier branches. 
# # She creates a calculator branch and merges all the required branches from origin
branch_merge

# # Ann implements the calculator.py script in the calculator branch and pushes the branch it to origin.
implement_calculator_script

# # Suneet fetches the calculator branch, review the code and merges the calculator branch with master
code_review

# # Suneet appends a line in ProjectDetails.txt to indicate that the project is successfully completed.
concluding_remark

# # Suneet pushes the updated master branch to origin.
push_master

# # All the team members fetch the code from origin, and remove any local development branches. 
team_origin_fetch

# # Ann and Suneet carry out a git log --oneline --graph
final_inspection

# All done!