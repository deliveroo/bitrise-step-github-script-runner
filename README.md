# GitHub Bash Script Runner

Downloads the content of a script hosted in GitHub and runs it as a bash script. 
It is very similar to [Remote Bash Script Runner Step](https://github.com/bitrise-steplib/steps-remote-script-runner) but it allows you to do a couple of things more:

1. You can use it with private repos
2. You can pass command line arguments

Note: after implementing it, I've found it already exists a [GitHub Script Runner](https://github.com/AndersonLasak/bitrise-step-github-script-runner)...but it doesn't allow to pass command line arguments, so this work is not completely wasted :_D

## How to use this Step

### Locally, from the CLI

Can be run directly with the [bitrise CLI](https://github.com/bitrise-io/bitrise),
just `git clone` this repository, `cd` into it's folder in your Terminal/Command Line
and call `bitrise run cli-test`.

*Add `GITHUB_TOKEN`to your `.bitrise.secrets.yml` file!*

Step by step:

1. Open up your Terminal / Command Line
2. `git clone` the repository
3. `cd` into the directory of the step (the one you just `git clone`d)
5. Create a `.bitrise.secrets.yml` file in the same directory of `bitrise.yml`
   (the `.bitrise.secrets.yml` is a git ignored file, you can store your secrets in it)
6. Add your GitHub personal access token to `.bitrise.secrets.yml` (use `GITHUB_TOKEN` as the key)
7. Run this step with the [bitrise CLI](https://github.com/bitrise-io/bitrise): `bitrise run cli-test`

An example `.bitrise.secrets.yml` file:

```
envs:
- GITHUB_TOKEN: {your_personal_access_token}
```

### From a Bitrise step, using `bitrise.yml`

If you want to use your step in your project's `bitrise.yml`, reference it in your `bitrise.yml` with the `git::https://github.com/deliveroo/bitrise-step-github-script-runner.git` step reference style:

```
- git::https://github.com/deliveroo/bitrise-step-github-script-runner.git:
   title: The title of your step
   description: A description of your step (optional)
   inputs:
   - repository: {owner/repo} (e.g. deliveroo/mobile-scripts)
   - script_path: {path_relative_to_repo_root} (e.g. promon/promon-upload-file.sh)
   - branch: {default=master}
   - command_line_arguments: {the same arguments you'd pass to a local script} (e.g. --local-file-path "$BITRISE_SOURCE_DIR/README.md" --remote-folder-path "deliveroo/Upload/rider")
   - github_token: {your personal access token or leave it empty if you have a GITHUB_TOKEN secret configured}
```

That's all ;)
