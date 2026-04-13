#!/bin/bash -l

# Get gisplot2 from the Ghub svn repository.
# Also see https://theghub.org/tools/gisplot2/wiki/GettingStarted

rm -rf gisplot2
svn checkout https://theghub.org/tools/gisplot2/svn/trunk gisplot2

# Make sure version checked out from the repository works.
# On macOS, the -i (in-place) flag requires the extension argument ''.
# Use anaconda-7.
sed -i '' 's|"display_name": "geospatial-plus python3"|"display_name": "Python 3 (ipykernel)"|g' gisplot2/gisplot2_jupyter.ipynb
sed -i '' 's|"name": "geospatial-anaconda-6"|"name": "python3"|g' gisplot2/gisplot2_jupyter.ipynb
# Use mounted shared storage.
sed -i '' 's|session =|#session =|g' gisplot2/gisplot2_jupyter.ipynb
sed -i '' "s|upload_directory = '/data/groups/ghub/tools/gisplot2/'+session|upload_directory = '/home/ghubuser/generated-data'|g" gisplot2/gisplot2_jupyter.ipynb
sed -i '' "s|path = '/data/groups/ghub/tools/reference/gis'|path = '/home/ghubuser/input-data/reference/gis'|g" gisplot2/gisplot2_jupyter.ipynb
sed -i '' "s|path = '/data/groups/ghub/tools/reference/ais'|path = '/home/ghubuser/input-data/reference/ais'|g" gisplot2/gisplot2_jupyter.ipynb
