#!/bin/bash -l

# Get alps from the Ghub svn repository.
# Also see https://theghub.org/tools/alps/wiki/GettingStarted

rm -rf alps
svn checkout https://theghub.org/tools/alps/svn/trunk alps
