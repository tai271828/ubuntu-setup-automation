#!/bin/bash
LOG_SOLVCON="/var/log/cloud-init-solvcon.log"
echo "Begin to initialize SOLVCON" > ${LOG_SOLVCON}

if [[ `whoami` == "ubuntu" ]]; then
  # some debug information
  whoami >> ${LOG_SOLVCON}
  echo ${HOME} >> ${LOG_SOLVCON}
  pwd >> ${LOG_SOLVCON}
  dirname $0 >> ${LOG_SOLVCON}
  # do real SOLVCON stuff
  git clone https://github.com/solvcon/solvcon.git ${HOME}/solvcon
  wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /home/ubuntu/miniconda.sh
  bash ${HOME}/miniconda.sh -b -p ${HOME}/miniconda

  SCSRC=${HOME}/solvcon

  export PATH="${HOME}/miniconda/bin:$PATH"
  ${SCSRC}/contrib/devenv/create.sh
  source ${SCSRC}/build/env/start
  ${SCSRC}/contrib/conda.sh 
fi
