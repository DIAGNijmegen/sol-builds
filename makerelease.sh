#!/bin/bash

tag_name="`tr -c '[a-zA-Z0-9_\-.]' _  <<< $( niet dockerbase defs.yaml )__munge_$( niet munge_version defs.yaml )__slurm_$( niet slurm_version defs.yaml ) | sed 's/_*$//'`"
echo "Creating release with tag: $tag_name"

if ! git diff-index --quiet HEAD -- ; then
  echo 'ERROR: Please commit all changes to git before proceeding!'
  exit 1
fi

set -e

git push
git tag "$tag_name"
git push --tags
