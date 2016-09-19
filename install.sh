#!/bin/bash

# Install Root Pages

html_dir="./html"
install_dir="${HOME}/rp"

# create the necessary directories
mkdir -p ${install_dir}/{bin,html}
# export the local user's installation directory
export_cmd="export PATH=${PATH}:${install_dir}/bin"
echo ${export_cmd} >> ${HOME}/.bashrc
# delete any old/outdated Root Pages files
rm -rf ${install_dir}/html/*
# copy over the latest files
cp -f -R ${html_dir}/ ${install_dir}/html/
# replace the old "rp" script
cp -f ./rp ${install_dir}/bin/rp
# make sure it has executable permissions
chmod 755 ${install_dir}/bin/rp
echo 'Installation complete!'
echo "Source ${HOME}/.bashrc to start using the 'rp' command."
exit 0
