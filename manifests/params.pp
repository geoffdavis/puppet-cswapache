class apache::params {
  case $::operatingsystem {
    Solaris: {
      $package_name = 'apache2'
      $service_name = 'cswapache2'
      $template = 'apache/vhost.conf.erb'
      $conf_dir = '/opt/csw/apache2/etc'
      $vhosts_dir = "${conf_dir}/vhosts.d"
      $logdir = '/opt/csw/apache2/var/log'
      $owner = 'root'
      $group = 'other'
      $apache_runas_user = 'webservd'
      $apache_runas_group = 'webservd'
      $apache_serveradmin = 'anf-sysadmins@anfmon.ucsd.edu'
    }
    default: {
      fail("Unsupported os $::operatingsystem for Apache module")
    }
  }
}
