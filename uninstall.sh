#!/bin/bash

# remove the export line ending in "rp/bin"
sed -i _rp_uninstall -e '/rp\/bin$/d' ${HOME}/.bashrc
# delete the installation directory
rm -rf ${HOME}/rp
