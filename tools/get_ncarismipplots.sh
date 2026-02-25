#!/bin/bash -l

# Get ncarismipplots from the Ghub svn repository.
# Also see https://theghub.org/tools/ncarismipplots/wiki/GettingStarted

rm -rf ncarismipplots
svn checkout https://theghub.org/tools/ncarismipplots/svn/trunk ncarismipplots
