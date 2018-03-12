#!/bin/bash
LOG_GENERIC="/var/log/cloud-init-userdata.log"
echo "Begin to initialize as a normal user" > ${LOG_GENERIC}
chown ubuntu ${LOG_GENERIC}

if [[ `whoami` == "ubuntu" ]]; then
  # some debug information
  whoami >> ${LOG_GENERIC}
  echo ${HOME} >> ${LOG_GENERIC}
  pwd >> ${LOG_GENERIC}
  dirname $0 >> ${LOG_GENERIC}

fi
