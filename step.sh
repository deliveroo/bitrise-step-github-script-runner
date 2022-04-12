#!/bin/bash

# Downloads the content of a script hosted in GitHub and runs it as a bash script.
# It is very similar to Remote Bash Script Runner Step but you can also:
#
#   1. Use it with private repos
#   2. Pass command line arguments

set -e

function echoerr() { echo "$@" 1>&2; }

# --- Input validation ---

if [ -z $repository ]; then
    echoerr "Missing \$repository env var"
    exit 1
fi

if [ -z $script_path ]; then
    echoerr "Missing \$script_path env var"
    exit 1
fi

if [ -z $branch ]; then
    echoerr "Missing \$branch env var"
    exit 1
fi

if [ -z $github_token ]; then
    echoerr "Missing \$github_token env var"
    exit 1
fi

echo "repository = $repository"
echo "script_path = $script_path"
echo "branch = $branch"
echo "command_line_arguments = $command_line_arguments"

echo "Downloading the remote script locally..."

curl -H "Authorization: token $GITHUB_TOKEN" \
  -H 'Accept: application/vnd.github.v3.raw' \
  -sSL "https://api.github.com/repos/$repository/contents/$script_path?ref=$branch" &> remote-script.sh
chmod +x remote-script.sh

echo "Running the remote script..."

command="./remote-script.sh $command_line_arguments"
bash -c "$command"