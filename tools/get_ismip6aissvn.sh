#!/bin/bash -l

# Get ismip6aissvn from the Ghub svn repository.
# Also see https://theghub.org/tools/ismip6aissvn/wiki/GettingStarted

rm -rf ismip6aissvn
svn checkout https://theghub.org/tools/ismip6aissvn/svn/trunk ismip6aissvn

# Make sure version checked out from the repository works.
# On macOS, the -i (in-place) flag requires the extension argument ''.
# Use anaconda-7
sed -i '' 's|"name": "geospatial-anaconda-6"|"name": "geospatial-2021-09"|g' ismip6aissvn/GHub.ipynb

