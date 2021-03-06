# vagrant-agt

Vagrant template for Amazon-CLI, Google-CLI, Terraform in one quick install template;

This template should create easy to use, quick way to install [Amazon Cloud CLI](https://aws.amazon.com/cli/), 
[Terraform](https://www.terraform.io/) and [Google Cloud CLI](https://cloud.google.com/pubsub/docs/quickstart-cli) in isolated Ubuntu VM.

### It will help:
- Get access to Amazon Cloud or Google Cloud CLI's from VM;
- Work with untrusted versions of software / repositories without trashing your host system;
- Keep different versions of packages than on your host;
- Keep all files related with specific environment in one place - git(permanent) and VM(temporary);
- Safely run "curl bla-bla| sudo bash" installation commands as they are isolated in VM;
- Use shorten old school make style commands to perform some basic actions;
- Safely migrate your single Cloud access point via different distos or desktops;

![](https://raw.githubusercontent.com/mn3m0nic/vagrant-agt/master/docs/vis.png)

### Requirements for host system:

- Debian 9 "Stretch" or Devuan 2 "ASCII", can work on Ubuntu (not tested yet);
- Installed "make", "vagrant" and "VirtualBox";

```bash
sudo apt-get update
sudo apt-get install virtualbox vagrant make
```
- Virtualization support and enabled in BIOS/UEFI/whatever;

### Sharing data with VM

By default please store date to "shared" dir which will be in /mnt/v on VM:

```
vagrant@amazon-test01:~$ ls -lah /mnt/v/
total 28M
drwxr-xr-x 1 vagrant vagrant 4.0K Nov  8 10:33 .
drwxr-xr-x 3 root    root    4.0K Nov  8 10:45 ..
-rw-r--r-- 1 vagrant vagrant  14M Oct 25 16:03 terraform_0.10.8_linux_amd64.zip

```

Also configs in .aws and .config will be shared;
To add more shares - edit Vagrandfile file;

### Quick start on Debian/Devuan/Ubuntu based system:

```bash
E=production; mkdir -p work/$E; cd work/$E
svn export https://github.com/mn3m0nic/vagrant-agt/trunk/environment/debian-agt/ .
make init
make
make all
make ssh
```

### Usage:

```bash
Usage:
	make <COMMAND> [args]

Available commands:


Available commands:
        all    - stop, kill, create, start and ssh = start fresh copy (no configure)
        c      - configure AWS-CLI 
        cg     - configure Google CLI 
        clean  - remove '.aws', '.config' and 'shared' dirs data
        cli    - connect to AWLESS (console with autocompletion for AWS) 
        help   - show this help
        init   - Init your host system and working dir
        init-pkg - Install vagrant, VirtualBox 
        init-dirs - Create "permanent" dirs to store shared data with VM
        kill   - destroy VM (.aws/* and shared/* files will be untouched)
        listg  - get some data from Google Cloud 
        list   - list of some offten used commands to get date from AWS 
        ssh    - connect to VM via SSH 
        start  - start or create(if it's not exist) and start VM 
        status - get status of current VM;
        stop   - suspend VM
```


### Existing configs installation

You need to store .aws and .config directory to somewhere and copy it back into fresh install:

```bash
E=test-8; mkdir -p work/$E; cd work/$E
svn export https://github.com/mn3m0nic/vagrant-agt/trunk/environment/debian-agt/ .
make init
cp -v SOURCE_CONFIGS/.aws/* .aws/
cp -v SOURCE_CONFIGS/.config/* .config/
make all
make ssh
```

### TODO list

- [X] AWS-CLI install
- [X] AWLESS install
- [X] Terraform install
- [X] Google-CLI install
- [X] Basic testing of binary files presense after installation
- [X] User env's specific configuration
- [X] Remove not required files from local git copy (images \ Readme \ .git) - used SVN export;


