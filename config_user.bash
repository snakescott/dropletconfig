# Basic configuration for an Ubuntu 12.04 x64 Digital Ocean Droplet
# Notes:
# 1) Assumes you have cert-based ssh access as root
# 2) Is not idempotent :(

# Fail fast
set -o errexit -o nounset

# Check required env vars
for i in REMOTE_USER REMOTE_HOST PUBLIC_KEY_FILE; 
  do 
  if [[ "${!i}" == "" ]]; then echo "Must set $i env var" &&  exit 1; fi ;
done

scp "$PUBLIC_KEY_FILE" "root@$REMOTE_HOST:public_key.tmp"

# some of this is fairly fragile, should look into more declarative config

ssh "root@$REMOTE_HOST" \
  "adduser --disabled-password --gecos '' $REMOTE_USER;
  adduser $REMOTE_USER sudo;
  mkdir ~$REMOTE_USER/.ssh;
  mv ~/public_key.tmp ~$REMOTE_USER/.ssh/authorized_keys;
  chmod 700 ~$REMOTE_USER/.ssh;
  chmod 600 ~$REMOTE_USER/.ssh/authorized_keys;
  chown -R $REMOTE_USER:$REMOTE_USER ~$REMOTE_USER/.ssh;
  cp /etc/sudoers /etc/sudoers.bak
  echo '$REMOTE_USER ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers;
  cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
  perl -pi -e 's/.?PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config;
  perl -pi -e 's/.?PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config;
  reload ssh;
  "