class apache::service {
  require 'apache::params'

  service { $apache::params::service_name :
    ensure      => running,
    hasstatus   => true,
    hasrestart  => true,
    enable      => true,
    require     => Class['apache::install'],
  }
}
