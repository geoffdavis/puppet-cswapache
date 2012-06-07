class cswapache::install {
  require 'cswapache::params'
  package { [ $cswapache::params::package_name ]:
    ensure => present,
  }
}
