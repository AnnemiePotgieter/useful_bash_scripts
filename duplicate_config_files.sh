#!/bin/bash

# Find all the ci-dev-drv directories in ci-config and find the generic files
find "ci-config" -type d -name "ci-dev-drv" | while read -r ci_dev_dir; do
    find "$ci_dev_dir" -type f -name "generic*" | while read -r generic_file; do
        # Duplicate the generic files to multi-pf files
        new_file="${generic_file/generic/mpf}"
        cp "$generic_file" "$new_file"
        # Update 'ethX: ' to replace all np# with f#np#
        sed -i -E "/^ethX: / s/(np[0-9]+)/f\1/" "$new_file"
    done
done