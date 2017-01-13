#!/usr/bin/env bash

URL=https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
ROOT_PREFIX=$BUILD_DIR/.heroku/miniconda

puts-step "Installing Miniconda"

pushd $CACHE_DIR > /dev/null
curl --output conda-installer.sh --time-cond conda-installer.sh --silent $URL | indent
bash conda-installer.sh  -p $ROOT_PREFIX/ -b | indent
popd > /dev/null


puts-step "Configuring Miniconda"

export PATH="$ROOT_PREFIX/bin:$PATH"
conda config --set always_yes yes --set changeps1 no
conda update --quiet conda conda-env | indent
conda info --all | indent

set-env PYTHONUNBUFFERED true
set-env LANG en_US.UTF-8
set-env PYTHONHASHSEED random
