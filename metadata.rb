maintainer       "DueDil Ltd"
maintainer_email "tom@duedil.com"

license          "Apache 2.0"
description      "Installs/Configures ganglia"

long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version          "0.2"

%w{ debian ubuntu redhat centos fedora }.each do |os|
  supports os
end
