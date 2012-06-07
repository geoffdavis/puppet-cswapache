class apache {
  require 'apache::params'
  include 'apache::install', 'apache::service', 'apache::config'
}
