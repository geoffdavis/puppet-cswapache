class apache::config {
  require 'apache::params'
  include 'apache'

  # Set some defaults for the File type
  File {
    owner   => $apache::params::owner,
    group   => $apache::params::group,
    require => Class['apache::install'],
    notify  => Class['apache::service'],
  }

# Set variables used by the httpd.conf template
  $apache_runas_user = $apache::params::apache_runas_user
  $apache_runas_group = $apache::params::apache_runas_group
  $apache_serveradmin = $apache::params::apache_serveradmin
  $apache_servername = $::fqdn

  case $::operatingsystem {
    Solaris: {
      file {"$apache::params::conf_dir/httpd.conf":
        content => template ("apache/${::operatingsystem}/httpd.conf.erb"),
        mode    => '0644',
      }

      file {"$apache::params::conf_dir/vhosts.d":
        ensure  => 'directory',
        mode    => '0755',
      }
    }
    default: {
      fail("Unsupported os ${::operatingsystem} for apache::config")
    }
  }
}
