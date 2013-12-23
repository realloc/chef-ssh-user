name             "ssh_user"
maintainer       "We Are Interactive"
maintainer_email 'franklin@weareinteractive.com'
license          'MIT'
description      'Installs/Configures ssh_user'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
recipe           "ssh_user", "Empty recipe for including LWRPs"
recipe           "ssh_user::data_bag", "Read data bag to include ssh configs"

# dependencies
%w{user ssh-util}.each do |d|
  depends d
end

# support (ubuntu debian redhat centos fedora freebsd)
%w{ubuntu}.each do |os|
  supports os
end
