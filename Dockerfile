ARG dockerbase
FROM $dockerbase

RUN apt-get update && apt-get install -y gcc git make gzip libgcrypt20-dev python libmariadbclient-dev

RUN mkdir -p /munge/git
WORKDIR /munge/git

#### Download, build, and configure MUNGE ####
RUN git clone https://github.com/dun/munge.git .

ARG munge_version
RUN git checkout -b build munge-${munge_version}
RUN ./configure --prefix=/opt/munge --with-crypto-lib=libgcrypt
RUN make -j install

ARG slurm_version
RUN mkdir -p /slurm/git
WORKDIR /slurm/git

#### Download and build SLURM ####
RUN git clone https://github.com/SchedMD/slurm.git .
RUN git checkout -b build slurm-${slurm_version}
RUN ./configure --prefix=/opt/slurm --with-munge=/opt/munge 
RUN make -j install

