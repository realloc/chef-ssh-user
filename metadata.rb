name             'ssh-util-user'
maintainer       'We Are Interactive'
maintainer_email 'franklin@weareinteractive.com'
license          'MIT'
description      'Installs/Configures ssh-util-user'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

# dependencies
%w{user ssh-util}.each do |d|
  depends d
end

# support (redhat centos ubuntu gentoo)
%w{ubuntu}.each do |os|
  supports os
end
