class apache::install {
  require 'apache::params'
  package { [ $apache::params::package_name ]:
    ensure => present,
  }
}
