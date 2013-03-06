# == Class: apacheprofile
#
# Full description of class apacheprofile here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { apacheprofile:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class apacheprofile {
	class {'apache':  }
	apache::vhost { 'www.example.com':
   	 priority        => '10',
    	 vhost_name      => '192.0.2.1',
    	 port            => '8000',
    	 docroot         => '/home/www.example.com/docroot/',
    	 logroot         => '/srv/www.example.com/logroot/',
   	 serveradmin     => 'webmaster@example.com',
   	 serveraliases   => ['example.com',],
	}
	include apache::mod::proxy
	include apache::mod::ssl
}
