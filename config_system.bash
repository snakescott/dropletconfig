# requires a terminal, so scp it to remote host and then execute
# Installs some basic packages (including ubuntu firewall and unattended-upgrades for getting security patches). 

set -o errexit -o nounset
sudo apt-get -y install git make gcc g++ screen unattended-upgrades landscape-common update-motd update-notifier ufw
sudo apt-get -y update
sudo apt-get -y upgrade
sudo dpkg-reconfigure -plow unattended-upgrades
sudo ufw allow ssh/tcp
sudo ufw logging on
sudo ufw enable
sudo ufw status
echo "Setup complete, you should probably reboot though"
