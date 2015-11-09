Conda/pip buildpack
===================

Heroku buildpack to install Python applications using conda and pip.

1. List package requirements in a `conda-requirements.txt` file in the root
   of the project. You can use `conda list -e` to get the info.
2. Optionally, list any non-default conda channels in a `conda-channels.txt`
   file.
3. Optionally, list any packages to be installed with pip in a 
   `requirements.txt` file.
4. Create a `.buildpacks` file and add the line
   `https://github.com/faph/conda-pip-buildpack.git`
5. Add the multi-buildpack (https://github.com/ddollar/heroku-buildpack-multi)
   to project.
6. Deploy to Heroku.

**Note**  
Currently, this buildpack installs the application in the miniconda root
environment (Python 3.4).
