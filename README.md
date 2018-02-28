# KVM-based Ubuntu Environment of SOLVCON
To automate Ubuntu installlation to run [SOLVCON](https://github.com/solvcon/solvcon).
# Getting Started

## Prerequisites
An Ubuntu Xenial desktop with the following files/tools/scripts of the packages installed:
- *libvirt.pc* (provided by *libvirt-dev*)
- *Python.h* (provided by *libpython3.5-dev*)
- *cloud-localds* (provided by *cloud-image-utils*)
- optional: You may want to have *virt-manager* or *virt-viewer* in your system to see the provisioned system.

### Install the Prerequisites

    sudo apt-get install libvirt-dev
    sudo apt-get install libpython3.5-dev
    sudo apt-get install cloud-image-utils

## Installing

    virtualenv -p python3 venv
    git clone https://github.com/tai271828/ubuntu-setup-automation.git
    source venv/bin/activate

If you want to connect the KVM system later over SSH, you need to paste your public ssh key in this session (replace *@@my_ssh_public_key@@* ). If you don't have a key or just want to use password to login, remove the whole session in order that cloud-init won't be confused by the invalid string *@@my_ssh_public_key@@*.

Change or remove this part of [user-data](https://github.com/tai271828/ubuntu-setup-automation/blob/master/data/user-data)

    ssh_authorized_keys:
     - @@my_ssh_public_key@@

For example, it could be

    ssh_authorized_keys:
     - ssh-rsa AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA you@yourhost

# Run
Go to the root path of the source code branch, and run

    ./bin/solvcon-kvm

You may need to
- Provide your sudo password to execute some commands of the scripts.
- Make sure you are in the pre-requisites-ready working environment, e.g. a virtual Python environment installed necessary packages.

This executable, [solvcon-kvm](https://github.com/tai271828/ubuntu-setup-automation/blob/master/bin/solvcon-kvm), is a wrapper of several scripts to
- Download an Ubuntu image file.
- Create a KVM domain
- Install the Ubuntu image in the KVM domain
- Install SOLVCON in the Ubuntu system installed in the KVM domain

Once the installation completes, it will pop up IP information to access the KVM instance. Log in the instance by

    ssh ubuntu@<The IP shown on stdout>

with password *passw0rd*, or your private key if you have pasted your public key in [user-data](https://github.com/tai271828/ubuntu-setup-automation/blob/master/data/user-data).

After provisioning, you will get the files and folders shown below:

| File/Folder | Description |
| solvcon | SOLVCON source code. It is pulled by git. |
| miniconda | Miniconda environment. It is ready to run SOLVCON and enabled when you log in the guest system. |
| cloud-init-solvcon-output.log | cloud-init output log when installing SOLVCON. If the installation completes, the log should show the unit test results. |
