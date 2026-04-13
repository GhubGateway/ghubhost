#!/bin/bash -l

# Get icesheet1 from the Ghub git repository.
# Also see https://theghub.org/tools/icesheet1/wiki/GettingStarted

rm -rf icesheet1
git clone https://theghub.org/tools/icesheet1/git/icesheet1 icesheet1

# Make sure version checked out from the repository works.
# On macOS, the -i (in-place) flag requires the extension argument ''.
sed -i '' 's|import hublib.use|#import hublib.use|g' icesheet1/icesheet1.ipynb
sed -i '' "s|name = 'Run Simulation Form', width='40%'|name = 'Run Simulation Form', width='46%'|g" icesheet1/icesheet1.ipynb
sed -i '' 's|#FC = gfortran|FC = gfortran|g' icesheet1/src/makefile
sed -i '' 's|FC = ifort|#FC = ifort|g' icesheet1/src/makefile
sed -i '' 's|#FCFLAGS = -O2|FCFLAGS = -O2|g' icesheet1/src/makefile
sed -i '' 's|FCFLAGS = -O2 -assume byterecl|#FCFLAGS = -O2 -assume byterecl|g' icesheet1/src/makefile
sed -i '' 's|. /etc/environ.sh|#. /etc/environ.sh|g' icesheet1/run_icesheet.sh
sed -i '' 's|use -e -r anaconda-7|#use -e -r anaconda-7|g' icesheet1/run_icesheet.sh
sed -i '' 's|. "/apps/share64/debian10/anaconda/anaconda-7/etc/profile.d/conda.sh"|#. "/apps/share64/debian10/anaconda/anaconda-7/etc/profile.d/conda.sh"|g' icesheet1/run_icesheet.sh
sed -i '' 's|conda activate "/apps/share64/debian10/anaconda/anaconda-7/envs/geospacial-plus-2"|source activate "/home/ghubuser/anaconda/anaconda-7/envs/geospacial-plus-2"|g' icesheet1/run_icesheet.sh
sed -i '' 's|. /etc/environ.sh|#. /etc/environ.sh|g' icesheet1/plot.sh
sed -i '' 's|use -e -r anaconda-7|#use -e -r anaconda-7|g' icesheet1/plot.sh
sed -i '' 's|. "/apps/share64/debian10/anaconda/anaconda-7/etc/profile.d/conda.sh"|#. "/apps/share64/debian10/anaconda/anaconda-7/etc/profile.d/conda.sh"|g' icesheet1/plot.sh
sed -i '' 's|conda activate "/apps/share64/debian10/anaconda/anaconda-7/envs/geospacial-plus-2"|source activate "/home/ghubuser/anaconda/anaconda-7/envs/geospacial-plus-2"|g' icesheet1/plot.sh




