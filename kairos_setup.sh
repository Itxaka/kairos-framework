#!/bin/bash

type=$1
valid_types="systemd systemd-fips openrc"
framework_temp_dir="/framework_temp"
framework_final_dir="/framework"

function exists_in_list() {
    LIST=$1
    VALUE=$2
    DELIMITER=" "
    LIST_WHITESPACES=`echo $LIST | tr "$DELIMITER" " "`
    for x in $LIST_WHITESPACES; do
        if [ "$x" = "$VALUE" ]; then
            return 0
        fi
    done
    return 1
}

if [ "${type}" = "" ]; then
  echo "Error: System type not specified"
  echo "Script usage: $(basename "$0") TYPE" >&2
  echo "Valid types: ${valid_types// /, }"
  exit 1
fi


if ! exists_in_list "${valid_types}" "${type}"; then
  echo "Error: Invalid type: ${type}"
  echo "Valid types: ${valid_types// /, }"
  exit 1
fi

# check if dir exists
if [ ! -d "${framework_temp_dir}/${type}" ]; then
  echo "Error: Directory ${framework_temp_dir}/${type} does not exist"
  exit 1
fi

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "Using system type: ${type}"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"



cp -vR "${framework_temp_dir}/common/" "${framework_final_dir}"
cp -vR "${framework_temp_dir}/${type}/" "${framework_final_dir}"
