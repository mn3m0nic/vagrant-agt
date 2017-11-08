## Makefile v0.01
define HELP_BODY
Usage:
	make <COMMAND> [args]

Available commands:
	all    - stop, kill, create, start and ssh = start fresh copy (no configure)
	cli    - connect to AWLESS (console with autocompletion for AWS) 
	c      - configure AWS-CLI 
	cg     - configure Google CLI 
	init   - Init your host system and working dir
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

init:
	sudo aptitude update
	sudo aptitude install -y vagrant virtualbox devscripts apt-cacher-ng
	vagrant box add precise32 http://files.vagrantup.com/precise32.box
	mkdir .aws shared .config
stop:
	vagrant suspend
kill:
	vagrant destroy

clean: 	
	rm -rfv .aws
	rm -rfv .config
	#rm -rfv shared

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


