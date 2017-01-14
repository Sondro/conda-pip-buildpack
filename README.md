Conda/pip buildpack
===================

Heroku buildpack ([docs](https://devcenter.heroku.com/articles/buildpacks)) to
install Python applications using [conda](http://conda.pydata.org) and
[pip](https://pypi.python.org).

Configure this buildpack on your Heroku application like this:

```bash
heroku buildpacks:set https://github.com/faph/conda-pip-buildpack.git#v1.3.0
```

Then, in the root of your project, create an `environment.yml` file like this:

```yaml
name: env  # anything goes
channels:
- custom-channel  # if required
- ...
dependencies:
- python=3.5.*
- other-conda-package
- ...
- pip:
  - pip-package  # if required
  - ...
```

See also the [conda env spec](https://github.com/conda/conda-env#environmentyml).

Alternatively, list conda packages in a `conda-requirements.txt` file, pip 
packages in a `requirements.txt` file (optional) and non-default conda channels
in a `conda-channels.txt` file.


Slug compilation
----------------

- The conda root environment is created at `/app/.heroku/miniconda`.
- The application’s environment is created and activated at
  `/app/.heroku/miniconda/envs/app_env`.
- The application itself is installed in `/app`.
- Django static files are collected (symlinked) if a `manage.py` file exists in
  the project’s root. If the constant `STATIC_ROOT` is not defined, this will
  silently fail.


Copyrights
----------

Based on a [conda buildpack](https://github.com/kennethreitz/conda-buildpack)
by Kenneth Reitz.

Licensed under the [MIT licence](LICENSE).
