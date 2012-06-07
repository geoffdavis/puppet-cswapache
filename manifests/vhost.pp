define apache::vhost(
  $port,
  $docroot,
  $priority,
  $ssl=false,
  $template=undef,
  $serveraliases = ''
) {
  include 'apache'
  require 'apache::params'

# Sanity check args
  if ! is_integer($port) {
    fail('apache::vhost: parameter port must be an integer')
  }
  if ! is_integer($priority) {
    fail('apache::vhost: parameter priority must be an integer')
  }
  validate_string($docroot)
  validate_bool($ssl)

  if ! $template {
    $template_real = $apache::params::template
  } else {
    validate_string($template)
    $template_real = $template
  }
  $logdir=$apache::params::logdir

  file {"${apache::params::vhosts_dir}/${priority}-${name}.conf":
    content => template ($template_real),
    owner   => $apache::params::owner,
    group   => $apache::params::group,
    mode    => '0644',
    require => Class['apache::install'],
    notify  => Class['apache::service'],
  }
} # define apache::vhost
