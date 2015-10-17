#! /bin/bash
set -e
set -x

IS_VMWARE=$(cat /proc/modules | grep -c 'vmxnet')
IS_VBOX=$(cat /proc/modules | grep -c 'vboxsf')
if [ $IS_VMWARE -gt 0 ] || [ $IS_VBOX -gt 0 ]; then
  echo "On virtual machine, testing if apt proxy is avalible"
  # For a default NAT setup on Virtualbox, the host is the default gateway
  GATEWAY=$(ip route show | grep ^default | cut -d' ' -f 3)
  HOST=$GATEWAY
  if [ $IS_VMWARE -gt 0 ]; then
    # For a default NAT setup on Vmware, the host is the default gateway minus one
    HOST="$(echo -n $GATEWAY | cut -d . -f 1-3).$(($(echo $GATEWAY | cut -d . -f 4 )-1))"
  fi
  APT_PROXY="http://$HOST:3142"
  HAS_PROXY=$(wget $APT_PROXY 2>&1 | grep -c 'ERROR 404: Usage Information';)
  if [ $HAS_PROXY -eq 1 ]; then
    echo "There appears to be a apt proxy on $APT_PROXY, using it"
    echo "Acquire::http { Proxy \"$APT_PROXY\"; };" >> /etc/apt/apt.conf.d/01proxy
  else
    echo "Test for apt proxy on $APT_PROXY failed, not using proxy" 1>&2
  fi
fi

IN_NORWAY=$(curl -q http://ipinfo.io/country 2>&1 | grep -c '^NO$' || true)

if [ $IN_NORWAY -gt 0 ]; then
  sed -i -e 's|http://us.archive.ubuntu.com|http://no.archive.ubuntu.com|' /etc/apt/sources.list
fi

# Make debconf use a frontend that expects no interactive input at all, 
# preventing it from even trying to access stdin.
export DEBIAN_FRONTEND=noninteractive

apt-get --yes update

apt-get --yes upgrade

# Some standard tools
apt-get install --yes language-pack-nb vim htop git

cd /root

# to avoid unnessesary traffic
#if [ -d "/vagrant/repo" ]; then
#  cp -R /vagrant/repo .
#else
#  git clone https://github.com/user/repo.git
#fi

