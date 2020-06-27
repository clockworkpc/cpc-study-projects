#!/usr/bin/env bash

function pause(){
  read -p "$*"
}

echo "You are currently on this branch"
echo ""

git branch | grep "\*" | grep -Po '[A-Za-z].*'

echo ""
echo "==========================================="
echo ""

pause "Are you sure you are ready to run Cucumber?
(Press [Enter] to continue or Ctrl-c to cancel)"

echo "Running Cucumber"
bundle exec cucumber --format pretty

pause "Are you sure you are ready to run RSpec?
(Press [Enter] to continue or Ctrl-c to cancel)"

echo "Running RSpecs"
bundle exec rspec --format documentation

pause "Are you sure you are ready to run Rubocop?
(Press [Enter] to continue or Ctrl-c to cancel)"

echo "Running Rubocop"
bundle exec rubocop --debug

echo "You have modified these files:"
git status
