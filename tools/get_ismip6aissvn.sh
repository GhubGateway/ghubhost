#!/bin/bash -l

# Get ismip6aissvn from the Ghub svn repository.
# Also see https://theghub.org/tools/ismip6aissvn/wiki/GettingStarted

rm -rf ismip6aissvn
svn checkout https://theghub.org/tools/ismip6aissvn/svn/trunk ismip6aissvn
