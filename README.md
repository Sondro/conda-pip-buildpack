Conda/pip buildpack
===================

Heroku buildpack ([docs](https://devcenter.heroku.com/articles/buildpacks)) to
install Python applications using [conda](http://conda.pydata.org) and
[pip](https://pypi.python.org).

1. List package requirements in a `conda-requirements.txt` file in the root of
   the project. You can use `conda list -e` to get the info.
2. Optionally, list any non-default conda channels in a `conda-channels.txt`
   file.
3. Optionally, list any packages to be installed with pip in a
   `requirements.txt` file.
4. Create a `.buildpacks` file and add the line:  
   `https://github.com/faph/conda-pip-buildpack.git#v1.1.0`  
   Leave out the tag if you want to get the latest version each time.
5. Add the [multi-buildpack](https://github.com/ddollar/heroku-buildpack-multi)
   to the project with  
   `heroku buildpacks:set https://github.com/ddollar/heroku-buildpack-multi.git`.
6. Deploy to Heroku.

*Instead* of steps 1 to 3, you can also just provide an `environment.yml` file
like this:

```yaml
name: env  # anything goes
channels:
- custom_channel
- ...
dependencies:
- python=3.4.*
- other_conda_package
- ...
- pip:
  - pip_package
  - ...
```

See also the [conda env spec](https://github.com/conda/conda-env#environmentyml).

**Notes**

- The conda root environment is created at ``/app/.heroku/miniconda``.
- The application's environment is created and activated at
  ``/app/.heroku/miniconda/envs/app_env``.

Based on a [conda buildpack](https://github.com/kennethreitz/conda-buildpack)
by Kenneth Reitz.
