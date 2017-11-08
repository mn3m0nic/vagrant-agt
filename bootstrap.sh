#!/usr/bin/env bash
DNSRESOLVER='8.8.8.8'
APTCACHEIP='192.168.1.100'
init()
{
  #echo 'Acquire::http { Proxy "http://'${APTCACHEIP}':3142"; };' > /etc/apt/apt.conf.d/02proxy 
  #echo 'nameserver '$DNSRESOLVER > /etc/resolv.conf
  #chattr +i /etc/resolv.conf
  apt-get update
  apt-get install -y python-pip python3-pip unzip vim mc bash-completion git wget groff lsb-release curl
}
aws()
{
  echo "Installing AWS CLI"
  pip install awscli 
  echo "Installing AWS SHELL"
  pip install aws-shell
}
golang()
{
  ### IF YOU NEED GO-LANG than add golang to main
  ### not required by default
  echo "Installing GO Lang 1.9"
  add-apt-repository -y ppa:gophers/archive
  apt update
  apt-get install -y golang-1.9-go 
  mkdir -vp /usr/local/go/{src,bin,pkg}
  chmod -Rc 755 /usr/local/go
  echo "export GOPATH=/usr/local/go" >> ~/.bashrc
  export PATH=$PATH:/usr/lib/go-1.9/bin/
  echo "export PATH=$PATH:/usr/lib/go-1.9/bin/" >> ~/.bashrc
}
terraform()
{
  local F
  echo "Installing Terraform..."
  F="terraform_0.10.8_linux_amd64.zip"
  cd /mnt/v
  if [ ! -f "$F" ]; then
    wget -q "https://releases.hashicorp.com/terraform/0.10.8/${F}"
  fi
  unzip -j -d /usr/local/bin/  /mnt/v/${F}
  cd ~
}
awless()
{
  echo "Installing AWLESS"
  ##go get -u github.com/wallix/awless
  cd ~
  curl -s https://raw.githubusercontent.com/wallix/awless/master/getawless.sh | bash
  mv -v awless /usr/local/bin/
}
google()
{
  echo "Installing Google Cloud CLI tools"
  export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
  echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  sudo apt-get update 
  sudo apt-get install -y google-cloud-sdk google-cloud-sdk-app-engine-java google-cloud-sdk-app-engine-python google-cloud-sdk-pubsub-emulator google-cloud-sdk-bigtable-emulator google-cloud-sdk-datastore-emulator kubectl
  #gcloud init
}
#gcloud compute instances list
testing()
{
  cd ~
  echo "--- testing ---"
  #aws ec2 describe-instances
  echo "All done."
}
main()
{
  echo "Started $(basename $0) at `date`"
  init
  aws
  terraform
  #golang
  awless
  google
  testing
  echo "Complete at `date`."
}
main "$@" | tee /mnt/v/$(basename $0)"-"$(date +"%Y%m%d_%H%M%S" )".log"
