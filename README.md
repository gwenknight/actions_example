# actions_example
An example repository for using GitHub Actions, particularly as a cluster.

This repository contains 2 analysis scripts which can be executed remotely on the GitHub servers by running the action called "A GitHub action".

## How do you run "A GitHub action"?

The action has a manual trigger, to activate it click the "Actions" tab, the click "A GitHub action" in the workflows section on the left. Finally, use the "Run workflow" menu to start the action.

## What happens when you run "A GitHub action"?

This will launch two parallel jobs, with each job sourcing one of the R scripts in the "/Analysis" folder. These scripts will each produce a new plot in the "/Results" folder. These new plots will then be pushed to the repository once they are created.

## What do the analysis scripts do?

One just creates a histogram with a random samples of 1000 values drawn from a random distribution, and the other runs Conway's Game of Life for 120 iterations and saves the output to a GIF file.

But that's not super relevant - the point is that you could tell the action to source any R script you like, and that's what it will do!

## How do I modify a GitHub action?

Head over to the file ".github/workflows/a_github_action.yml". This file contains all the instructions to define the action.

NOTE: I'm not 100% sure why, but I can't edit action files locally, so you might have to modify the file through github.com directly.

## What do all the lines in the .yml file mean?

I suggest you read the official [GitHub actions documentation](https://docs.github.com/en/actions/creating-actions/metadata-syntax-for-github-actions) to better understand this.
