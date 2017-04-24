#!/bin/bash

# remove the export line ending in "rp/bin",
# backing up the .bashrc as .bashrc_rp_uninstall
sed -i'_rp_uninstall' -e '/rp\/bin$/d' ${HOME}/.bashrc
# delete the installation directory
rm -rf ${HOME}/rp
