# SOL Builds

This repositoiry uses GitHub actions to build releases of public projects that do not provide pinned
versions of platform binaries for internal use. The packages currently built include:

* munged
* slurm

Check GitHub's release section to download built packages.

# Contribution

Please feel free to create a pull request (PR) against this repository with other version combinations
to create binaries for other library versions. When your PR is accepted, we will create a new release
and GitHub actions creates you build - or just for this repo to make your own builds!

# Using build artifacts

Slurm and munge are both packaged in a self-contained configuration that needs to be installed in the
`/opt/` directory for everything to work. Self-contained means that the etc-files reside in the
directories `/opt/munge/etc` and `/opt/slurm/etc`, respectively.

In addtion to that, the binaries require the following Ubuntu packages to be installed:
- libgcrypt20
- python 
- libmariadb3

# Creating new build artifacts

To create a new set of binaries for a different combination of operating systems and/or slurm/munge versions,
open and edit the file `defs.yaml`.

~~~~~~~~~~~~~~~~~~~~~~
dockerbase: ubuntu:20.04
munge_version: 0.5.13
slurm_version: 19-05-7-1
~~~~~~~~~~~~~~~~~~~~~~

dockerbase is the name of a base-Docker for the operating system you want to compile for. Builds are
run inside of a docker container as light-weight virtualization to build for different operating systems.
munge_version and slurm_version need to match _tag names_ of the corresponding GitHub repositories.

Save your changes and either start a local build (see next section) or initiate a release build. To initiate
a release build commit your changes to the git, then issue `./makerelease.sh` (requires write access to the
repository). This will auto-create a tag for the release and push that tag to the repository. About 5 minutes
later GitHub actions should have created a the release and publised attached the binaries.

# Running the builds locally

To run builds locally on your machine you need the following tools installed (on a Linux machine):

- niet (install via pip3)
- docker

When you have these tools installed, you can invoke `./build.sh` directly to start a build. The built
binaries will be placed in the directory `./export/`
