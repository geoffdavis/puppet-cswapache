class cswapache::params {
  case $::operatingsystem {
    Solaris: {
      $package_name = 'apache2'
      $service_name = 'cswapache2'
      $template = 'cswapache/vhost.conf.erb'
      $conf_dir = '/opt/csw/apache2/etc'
      $vhosts_dir = "${conf_dir}/vhosts.d"
      $logdir = '/opt/csw/apache2/var/log'
      $owner = 'root'
      $group = 'other'
      $cswapache_runas_user = 'webservd'
      $cswapache_runas_group = 'webservd'
    }
    default: {
      fail("Unsupported os $::operatingsystem for CSW Apache module")
    }
  }

  $cswapache_serveradmin = $::cswapache_serveradmin ? {
    ''      => 'someone@somewhere.com',
    default => $::cswapache_serveradmin,
  }
}
