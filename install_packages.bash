# requires a terminal, so scp it to remote host and then execute

set -o errexit -o nounset

sudo apt-get -y install git make gcc g++ screen unattended-upgrades \
 landscape-common update-motd update-notifier ufw etckeeper
sudo apt-get -y update
sudo apt-get -y upgrade
sudo dpkg-reconfigure -plow unattended-upgrades