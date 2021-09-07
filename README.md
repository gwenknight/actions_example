# actions_example
An example repository for using GitHub Actions, particularly as a cluster.

This repository contains 2 analysis scripts which can be executed remotely on the GitHub servers by running the action called "A GitHub action".

To use this repository with you account, just fork it!


## What is an action?

An action is a series of instructions to run some code remotely on a virtual computer hosted by GitHub. Here, I'm mostly interested in using this for the purpose of running long scripts remotely (ie not on my own computer), but actions are often used for convenience (eg to automate simple tasks, like automatically fetching and cleaning data every day).

In our example here, the GitHub action we will be looking at is very conveniently called "A GitHub action".


## How do I run "A GitHub action"?

The action has a manual trigger, to activate it click the "Actions" tab, then click "A GitHub action" in the workflows section on the left. Finally, use the "Run workflow" menu to start the action.


## What happens when I run "A GitHub action"?

This will launch two parallel jobs, with each job sourcing one of the R scripts in the "/Analysis" folder. These scripts will each produce a new plot in the "/Results" folder. These new plots will then be pushed to the repository to be saved.


## What do the analysis scripts do?

One just creates a histogram with a random samples of 1000 values drawn from a random distribution, and the other runs Conway's Game of Life for 120 iterations and saves the output to a GIF file.

But that's not super relevant - the point is that you could tell the action to source any R script you like, and that's what it will do!


## How do I modify a GitHub action?

Head over to the file ".github/workflows/a_github_action.yml". This file contains all the instructions to define the action.

**NOTE**: I'm not 100% sure why, but I can't edit action files locally, so you might have to modify the file through github.com directly.


## What do all the lines in the .yml file mean?

I suggest you read the official [GitHub actions documentation](https://docs.github.com/en/actions/creating-actions/metadata-syntax-for-github-actions) to better understand this.

Otherwise, I have commented all lines, so you should be able to understand what each one means.

Simply put, the file defines a **workflow** called "A GitHub action" (`name: A GitHub action`), which is **launched by a manual trigger** (`on: workflow_dispatch:`) and contains **two jobs running in parallel** (`script-run1` and `script-run2`).

Each job runs on **MacOS** (`runs-on: macos-latest`) and contains **six steps** (`steps:`).
1) Set up Homebrew: a manual installation of background processes needed to run the action.
2) Checkout repos: checkout the repository we are in (very much like when you load a repository on your own computer).
3) Set up R: installs R on the virtual computer.
4) Install dependencies: install all the R packages you will need for your analyses. **NOTE:** this doesn't automatically identify the packages you're using in your analysis scripts! You have to specify yourself the ones that have to be installed at this step.
5) Run R script: source the R script file containing the analysis code.
6) Commit and push files: commit and push the new plot created by the analysis script in the "/Analysis" folder.


## FAQ

### I've modified the action .yml file, but the action doesn't work now!
Since our workflow instructions are divided in steps, you should be able to identify what hasn't worked (eg: you haven't setup the virtual machine properly, you haven't installed an R package you need for your analysis, there is an error in your script...)


### I can see which step has failed, but have no clue what's going on :'(
The GitHub actions framework relies on external repositories and files, sometimes things break when there is a new version of a package or an R update. Here, Google will be your best friend to figure out what's happening!


### Can I run the jobs on something else than MacOS?
Yes, you can also run it on Linux by replacing `runs-on: macos-latest` by `runs-on: ubuntu-latest` - there are pros and cons to this.

Pros:
1) You can run up to 20 Linux jobs in parallel, versus only 5 MacOS jobs.
2) The minute multiplier for Linux jobs is 1 (see **"I want to run GitHub actions in a private repository"** section).

Cons:
1) Installation takes longer on a Linux virtual machine versus a MacOS one.
2) Linux virtual machine specs are lower (2 cores, 7GB of RAM) than those of the MacOS machines (3 cores, 14GB of RAM).

**TLDR:** stick with MacOS, except if you want to run a lot of jobs in parallel.


### Why are you telling the GitHub action to pull the repository before pushing changes in the final step?
Well spotted! That's because I'm running the jobs in parallel, which means that one will necessarily finish before the other, and push changes to the repository first. If the 2nd job doesn't first fetch these changes before trying to push further changes, git will complain. So, the simple workaround is to pull before pushing!

**NOTE:** even with this, sometimes you can be really unlucky and have two parallel jobs finishing at the same time... in that case, one will fail to push the changes. You will be able to spot this error in the logs.


### Can I run jobs FOREVER???
No, workflow runs are limited to 72h in total, and each job in a workflow can only run for 6h. Bear this in mind when designing your analysis - if the script takes longer than 6h to run, the job will end without saving anything! However, there are no limis on the number of actions you can run, except if...


### ... I want to run GitHub actions in a private repository!!
Private repositories means that your code is hidden from the public, which can sometimes matter depending on the sensitivity of your work. Unfortunately, GitHub actions usage is limited with private repositories (2,000 minutes per month for Free accounts, 3,000 for Pro - these limits are tied to your account, not to single repositories).

However, if you run jobs on MacOS, a multiplier of 10 will apply! This means that for every minute of MacOS job running, 10 minutes will be deduced from your monthly allowance. If you go over your monthly allowance, you will have to pay to keep using GitHub actions in a private repository.

