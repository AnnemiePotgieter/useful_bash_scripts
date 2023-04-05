#!/bin/bash

# Define a list of version numbers
versions=(
    kernel-v5.15.56-corigine.tgz
    kernel-v5.15.56-.tgz
    kernel-v6.15.56-.tgz
    kernel-v4.15.56-.tgz
    kernel-v5.0.1-.tgz
    kernel-v5.15.9-.tgz
    )

before_versions=$(printf '%s\n' "${versions[@]}")
echo "Before versions:"
echo "${before_versions[@]}"

# Sort the list of versions
my_sort=$(printf '%s\n' "${versions[@]}" | sort --version-sort)

# Print the sorted list of versions
echo "My sorted versions:"
echo "${my_sort[@]}"
