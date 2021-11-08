#!/bin/bash
source ./config.sh
mkdir -p backup
cp -r ${https_folder} ./backup/
