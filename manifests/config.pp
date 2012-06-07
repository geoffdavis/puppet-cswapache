class cswapache::config {
  require 'cswapache::params'
  include 'cswapache'

  # Set some defaults for the File type
  File {
    owner   => $cswapache::params::owner,
    group   => $cswapache::params::group,
    require => Class['cswapache::install'],
    notify  => Class['cswapache::service'],
  }

# Set variables used by the httpd.conf template
  $cswapache_runas_user = $cswapache::params::apache_runas_user
  $cswapache_runas_group = $cswapache::params::apache_runas_group
  $cswapache_serveradmin = $cswapache::params::apache_serveradmin
  $cswapache_servername = $::fqdn

  case $::operatingsystem {
    Solaris: {
      file {"$cswapache::params::conf_dir/httpd.conf":
        content => template ("cswapache/${::operatingsystem}/httpd.conf.erb"),
        mode    => '0644',
      }

      file {"$cswapache::params::conf_dir/vhosts.d":
        ensure  => 'directory',
        mode    => '0755',
      }
    }
    default: {
      fail("Unsupported os ${::operatingsystem} for cswapache::config")
    }
  }
}
