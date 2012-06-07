define cswapache::vhost(
  $port,
  $docroot,
  $priority,
  $ssl=false,
  $template=undef,
  $serveraliases = ''
) {
  include 'cswapache'
  require 'cswapache::params'

# Sanity check args
  if ! is_integer($port) {
    fail('cswapache::vhost: parameter port must be an integer')
  }
  if ! is_integer($priority) {
    fail('cswapache::vhost: parameter priority must be an integer')
  }
  validate_string($docroot)
  validate_bool($ssl)

  if ! $template {
    $template_real = $cswapache::params::template
  } else {
    validate_string($template)
    $template_real = $template
  }
  $logdir=$cswapache::params::logdir

  file {"${cswapache::params::vhosts_dir}/${priority}-${name}.conf":
    content => template ($template_real),
    owner   => $cswapache::params::owner,
    group   => $cswapache::params::group,
    mode    => '0644',
    require => Class['cswapache::install'],
    notify  => Class['cswapache::service'],
  }
}
