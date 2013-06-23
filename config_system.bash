# requires a terminal, so scp it to remote host and then execute
# Installs some basic packages (including ubuntu firewall and unattended-upgrades for getting security patches). 

# Check required env vars
for i in "SSH_PORT"; 
  do 
  if [[ "${!i}" == "" ]]; then echo "Must set $i env var" &&  exit 1; fi ;
done

sudo perl -pi -e 's/VCS="bzr"/VCS="git"/' /etc/etckeeper/etckeeper.conf
sudo etckeeper init
sudo etckeeper commit "Initial commit."

sudo perl -pi -e 's/.?PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo perl -pi -e 's/.?PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo perl -pi -e "s/Port 22/Port $SSH_PORT/" /etc/ssh/sshd_config
sudo etckeeper commit "Harden ssh"
sudo reload ssh

sudo ufw allow "$SSH_PORT/tcp"
sudo ufw logging on
sudo ufw enable
sudo ufw status
sudo etckeeper commit "ufw config"
echo "Setup complete. SSH is now running on port $SSH_PORT. You should probably reboot."
