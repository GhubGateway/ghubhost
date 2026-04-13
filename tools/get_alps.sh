#!/bin/bash -l

# Get alps from the Ghub svn repository.
# Also see https://theghub.org/tools/alps/wiki/GettingStarted

rm -rf alps
svn checkout https://theghub.org/tools/alps/svn/trunk alps

# Make sure version checked out from the repository works.
# On macOS, the -i (in-place) flag requires the extension argument ''.
sed -i '' '/import scipy.stats/a\
import warnings\
' alps/bin/Functions.py
sed -i '' '/import warnings/a\
warnings.filterwarnings("ignore", "Values in x were outside bounds during a minimize step")\
' alps/bin/Functions.py
