# run on droplet, at least for now

for i in "NEW_RELIC_LICENSE_KEY"; 
  do 
  if [[ "${!i}" == "" ]]; then echo "Must set $i env var" &&  exit 1; fi ;
done
sudo apt-get -y install wget
sudo wget -O /etc/apt/sources.list.d/newrelic.list http://download.newrelic.com/debian/newrelic.list
sudo apt-key adv --keyserver hkp://subkeys.pgp.net --recv-keys 548C16BF
sudo apt-get update
sudo apt-get -y install newrelic-sysmond
sudo nrsysmond-config --set license_key=$NEW_RELIC_LICENSE_KEY
sudo /etc/init.d/newrelic-sysmond start