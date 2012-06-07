class cswapache::service {
  require 'cswapache::params'

  service { $cswapache::params::service_name :
    ensure      => running,
    hasstatus   => true,
    hasrestart  => true,
    enable      => true,
    require     => Class['cswapache::install'],
  }
}
