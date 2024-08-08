#!/bin/bash

declare COMMIT_NUMBER

function usage() {
    if [ "$#" -gt 1 ]; then
        echo "Error: This script accepts either no argument or one argument - the commit number."
        echo "Usage: $0 [<commit_number>]"
        echo "  [<commit_number>] The number of commits to squash from the HEAD. Defaults to 2 if not supplied."
        exit 1
    fi
}

function getCommitNumber() {
    if [ "$#" -eq 1 ]; then
        COMMIT_NUMBER=$1
        if ! [[ $COMMIT_NUMBER =~ ^[0-9]+$ ]]; then
            echo "Error: Invalid commit_number parameter. It should be an integer."
            return 1
        fi
        if [ "$COMMIT_NUMBER" -lt 2 ]; then
            echo "Error: Commit_number parameter should be an integer greater than or equal to 2."
            return 1
        fi
    fi
    return 0
}

function checkError() {
    if [ "$#" -eq 0 ]; then
        COMMIT_NUMBER=2
        echo "INFO: No argument givens, number of commit to squash set to 2."
        return 0
    else
        if ! getCommitNumber "$@"; then
            return 1
        fi
    fi

    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo "Error: This script must be run inside a Git repository."
        return 1
    fi

    if [ "$(git log -$COMMIT_NUMBER --pretty=%B | wc -l)" -lt 4 ]; then
        echo "Error: There are less than two commits in this repository."
        return 1
    fi
    return 0
}

function getCommitMessage() {
    local _commit_number=$1
    git log --pretty=format:"BEGIN_HASH%h%n%B" | awk -v var="$_commit_number" '/^BEGIN_HASH/ {i++} i==var' | sed '1d;$d'
}

function quickSquash() {
    local _commit_number=$1
    local _commit_message=""

    _commit_message="$(getCommitMessage "$_commit_number")"
    git reset --soft HEAD~"$_commit_number"
    git commit -m "$_commit_message"
    echo "The last two commits have been squashed successfully!"
}

function main() {
    if ! checkError "$@"; then
        echo "An error has occured."
        usage
        return 1
    fi
    quickSquash "$COMMIT_NUMBER"
    return 0
}

main "$@"
