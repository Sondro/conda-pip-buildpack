#!/usr/bin/env bash

#!/usr/bin/env bash

ENV_NAME=app_env
APP_PREFIX=$BUILD_DIR/.heroku/miniconda/envs/$ENV_NAME


if [ -f environment.yml ]; then

    if [ ! -d $APP_PREFIX ]; then
        puts-step "Creating Conda environment"
        conda env create --name $ENV_NAME --file environment.yml --quiet True | indent
    else
        puts-step "Updating existing Conda environment"
        conda env update --name $ENV_NAME --file environment.yml --quiet True | indent
    fi

else

    if [ -f conda-channels.txt ]; then
        while read LINE; do
            if [[ ! "$LINE" == "#"* ]]; then
                conda config --add channels $LINE
            fi
        done < "conda-channels.txt"
    fi
    if [ -f conda-requirements.txt ]; then
        puts-step "Installing dependencies using Conda"
        if [ ! -d $APP_PREFIX ]; then
            conda create --prefix $APP_PREFIX --file conda-requirements.txt --quiet | indent
        else
            conda install --prefix $APP_PREFIX --file conda-requirements.txt --quiet | indent
        fi
    fi
    if [ -f requirements.txt ]; then
        puts-step "Installing dependencies using pip"
        $APP_PREFIX/bin/pip install -r requirements.txt | indent
    fi

fi

conda list --name $ENV_NAME | indent
conda clean -iltp > /dev/null

# Set context environment variables.
PATH="${HOME}/.heroku/miniconda/envs/${ENV_NAME}/bin:$PATH"
CONDA_DEFAULT_ENV=$ENV_NAME
set-env PATH "${HOME}/.heroku/miniconda/envs/${ENV_NAME}/bin:$PATH"  # /app/.heroku/... !
set-env CONDA_DEFAULT_ENV $ENV_NAME
