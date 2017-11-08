## Makefile v0.01
define HELP_BODY
Usage:
	make <COMMAND> [args]

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

Versions:
$(shell vagrant --version)
endef
export HELP_BODY

help:
	@echo "$${HELP_BODY}"

all:  stop kill start ssh

init-dirs:
	grep synced_folder Vagrantfile | awk '{print $$2}' | tr -d "," | sort -u | xargs -L1 mkdir -vp
	[ ! -f "shared/init.sh" ] && echo "echo \"manual steps\"" > shared/init.sh
	chmod a+x shared/init.sh

init-pkg:
	sudo aptitude update
	sudo aptitude install -y vagrant virtualbox devscripts apt-cacher-ng

init: init-dirs init-pkg

stop:
	vagrant suspend
kill:
	vagrant destroy
clean: 	
	@grep synced_folder Vagrantfile | awk '{print $$2}' | tr -d "," | sort -u | xargs -L1 echo rm -rfv
restart:
	vagrant destroy
	vagrant up
ssh:
	vagrant ssh
start:
	vagrant up
c:
	vagrant ssh -c "aws configure"
cg:
	vagrant ssh -c "gcloud init"
list:
	vagrant ssh -c "awless list users"
	vagrant ssh -c "awless list vpcs"
	vagrant ssh -c "awless list subnets"
	vagrant ssh -c "awless list instances --sort uptime"
	vagrant ssh -c "awless list s3objects"
listg:
	vagrant ssh -c "gcloud compute instances list"
cli:
	vagrant ssh -c "awless"

status:
	vagrant status
