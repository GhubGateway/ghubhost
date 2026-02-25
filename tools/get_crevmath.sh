#!/bin/bash -l

# Get crevmath from the Ghub svn repository.
# Also see https://theghub.org/tools/crevmath/wiki/GettingStarted

rm -rf crevmath
svn checkout https://theghub.org/tools/crevmath/svn/trunk crevmath
