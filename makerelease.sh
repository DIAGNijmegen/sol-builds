#!/bin/bash

tag_name="$( niet dockerbase defs.yaml )_munge_$( niet munge_version defs.yaml )_slurm_$( niet slurm_version defs.yaml )"

if ! git diff-index --quiet HEAD -- ; then
  echo 'Please commit all changes to git before proceeding!'
  exit 1
fi

git tag "$tag_name"
git push --tags
