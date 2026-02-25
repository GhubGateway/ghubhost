#!/bin/bash -l

# Get insolationiceex from the Ghub svn repository.
# Also see https://theghub.org/tools/insolationiceex/wiki/GettingStarted

rm -rf insolationiceex
svn checkout https://theghub.org/tools/insolationiceex/svn/trunk insolationiceex
