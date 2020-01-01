#!/bin/bash
# ======
: ${LAMBDA_ROOT:=${PWD}}

# Provide a variable with the location of this script.
#scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
#echo $scriptPath

# Source Scripting Utilities
# -----------------------------------
# These shared utilities provide many functions which are needed to provide
# the functionality in this boilerplate. This script will fail if they can
# not be found.
# -----------------------------------

#utilsLocation="${scriptPath}/lib/utils.sh" # Update this path to find the utilities.
utilsLocation="${LAMBDA_ROOT}/lib/utils.sh"

if [ -f "${utilsLocation}" ]; then
    source "${utilsLocation}"
else
    echo "Please find the file util.sh and add a reference to it in this script. Exiting."
    echo 'utilsLocation:' ${utilsLocation}
    exit 1
fi
# ======

docker rm -f jenkins
success 'jenkins service'

