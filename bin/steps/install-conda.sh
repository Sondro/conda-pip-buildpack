#!/usr/bin/env bash

MINICONDA_VER=latest
ROOT_PREFIX=$BUILD_DIR/.heroku/miniconda

puts-step "Installing Miniconda (version $MINICONDA_VER)"

pushd $CACHE_DIR > /dev/null
if [ ! -f Miniconda3-$MINICONDA_VER-Linux-x86_64.sh ]; then
    echo "Downloading Miniconda installer" | indent
    curl -Os https://repo.continuum.io/miniconda/Miniconda3-$MINICONDA_VER-Linux-x86_64.sh
else
    echo "Running Miniconda installer from cache" | indent
fi
bash Miniconda3-$MINICONDA_VER-Linux-x86_64.sh  -p $ROOT_PREFIX/ -b | indent
popd > /dev/null


puts-step "Configuring Miniconda"

export PATH="$ROOT_PREFIX/bin:$PATH"
conda config --set always_yes yes --set changeps1 no
conda update --quiet conda conda-env | indent
conda info --all | indent
