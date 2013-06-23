sudo su -c "echo 'deb http://gb.archive.ubuntu.com/ubuntu/ precise-backports main restricted universe multiverse' >> /etc/apt/sources.list"
sudo apt-get update
sudo apt-get -y install znc/precise-backports znc-dbg/precise-backports znc-dev/precise-backports znc-extra/precise-backports znc-perl/precise-backports znc-python/precise-backports znc-tcl/precise-backports
sudo adduser --disabled-password --gecos '' znc
