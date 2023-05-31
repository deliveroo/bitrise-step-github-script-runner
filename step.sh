#!/bin/bash

# Downloads the content of a script hosted in GitHub and runs it as a bash script.
# It is very similar to Remote Bash Script Runner Step but you can also:
#
#   1. Use it with private repos
#   2. Pass command line arguments

set -ex

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

if [ -z $tmp_folder ]; then
    echoerr "Missing \$tmp_folder env var"
    exit 1
fi

echo "repository = $repository"
echo "script_path = $script_path"
echo "branch = $branch"
echo "command_line_arguments = $command_line_arguments"
echo "tmp_folder = $tmp_folder"

mkdir -p $tmp_folder

echo "Downloading the remote script locally..."

downloaded_script_path="$tmp_folder/remote-script.sh"

curl -v -H "Authorization: token $GITHUB_TOKEN" \
  -H 'Accept: application/vnd.github.v3.raw' \
  -sSL "https://api.github.com/repos/$repository/contents/$script_path?ref=$branch" &> $downloaded_script_path
chmod +x $downloaded_script_path

echo "Running the remote script..."

cat $downloaded_script_path

command="$downloaded_script_path $command_line_arguments"
bash -c "$command"
