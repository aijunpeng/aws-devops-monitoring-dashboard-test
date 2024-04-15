#!/bin/bash

# Get reference for all important folders
deployment_dir="$PWD"
cdk_out_dirc="$deployment_dir/../source/cdk.out"

do_cmd () {
    echo "------ EXEC $*"
    $*
    rc=$?
    if [ $rc -gt 0 ]
    then
            echo "Aborted - rc=$rc"
            exit $rc
    fi
}

echo "------------------------------------------------------------------------------"
echo "[Init] Install dependencies for Lambda functions"
echo "------------------------------------------------------------------------------"
cd $cdk_out_dirc
echo "Current location: $PWD"
for folder in asset.* ; do
    cd "$folder"

    function_name=${PWD##*/}
    echo "Installing dependencies for $function_name"

    for temp_folder in ".nyc_output" ".venv-prod" ".venv-test" "__pycache__"; do
        if [ -d "$temp_folder" ]; then
            echo "$temp_folder exists, removing it"
            do_cmd rm -rf $temp_folder
        fi
    done

    if [ -e "requirements.txt" ]; then
        echo "Installing python lambda using virtual environment"
        python3 -m venv .venv-test
        echo "Activating virtual environment"
        source .venv-test/bin/activate
        python3 -m pip install -U pip setuptools
        echo "Executing pip3 install -q -r requirements.txt --target ./"
        python3 -m pip install -q -r requirements.txt --target ./
        echo "Deactivating virtual environment"
        deactivate
        echo "Deleting python virtual environment"
        rm -fr .venv-test
    elif [ -e "package.json" ]; then
        echo "Installing node dependencies"
        echo "Executing do_cmd npm install --omit=dev"
        do_cmd npm install --omit=dev
    fi

    cd ..
done

# Return to the directory where we started
cd $deployment_dir