# Git Quick Squash Script README

## Description

This bash script allows users to quickly squash the last n number of commits in a git repository. It's handy for cleaning up commit history before pushing to a remote branch. It also bundles commit messages into the new squashed commit message.

<em>Please note this script should be used with caution, as squashing commits will rewrite your commit history.</em>

## Usage

```bash
./quick-squash.sh [<commit_number>]
```

## Parameters

- `<commit_number>`: (Optional) The number of recent commits to squash from HEAD. Defaults to 2 if not supplied.

## Features

1. Squashes the last n number of commits together (defaults to 2 if no argument is supplied).
2. Bundles the commit messages of the squashed commits together in the squashed commit.
3. Error checks for invalid use cases such as being run outside of a Git repository and squashing when there are fewer than 2 commits in the repository.

## Errors

The script halts with an error message when:
- The number of commits to squash is less than 2.
- The argument passed is not an integer.
- It is run outside of a Git repository.
- There are fewer than 2 commits in the repository.

## Requirements

This script is written in bash and therefore requires a Unix-like operating system to run. 

Additionally, it requires Git to be installed and accessible via the command line, as it utilizes various Git commands.

## Disclaimer

This script modifies your Git commit history. Always double-check your branch status and ensure you've saved any work before running this script. 

## License

This project is licensed under the terms of the MIT license.
