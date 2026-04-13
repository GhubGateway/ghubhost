#!/bin/bash -l

# Get ncarismipplots from the Ghub svn repository.
# Also see https://theghub.org/tools/ncarismipplots/wiki/GettingStarted

rm -rf ncarismipplots
svn checkout https://theghub.org/tools/ncarismipplots/svn/trunk ncarismipplots

# Make sure version checked out from the repository works.
# On macOS, the -i (in-place) flag requires the extension argument ''.
# Use Anaconda-7 base and the ncar environments / kernel
sed -i '' 's|"display_name": "geospatial-plus python3"|"display_name": "Python3 (ncar)"|g' ncarismipplots/CESM_display_final.ipynb
sed -i '' 's|"name": "geospatial-anaconda-6"|"name": "ncar"|g' ncarismipplots/CESM_display_final.ipynb
