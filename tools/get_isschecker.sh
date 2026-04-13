#!/bin/bash -1

# Get isschecker from the Ghub git repository.
# Also see https://theghub.org/tools/isschecker/wiki/GettingStarted

rm -rf isschecker
git clone https://theghub.org/tools/isschecker/git/isschecker isschecker

# Make sure version checked out from the repository works.
# On macOS, the -i (in-place) flag requires the extension argument ''.
# Use Anaconda-7
sed -i '' 's|"display_name": "geospatial-plus python3"|"display_name": "Python 3 (ipykernel)"|g' isschecker/isschecker.ipynb
sed -i '' 's|"name": "geospatial-anaconda-6"|"name": "python3"|g' isschecker/isschecker.ipynb
