# == Class: papertrail
#
# See README.md
#
class papertrail (
  $log_port               = '',
  $log_host               = 'logs.papertrailapp.com',
  $papertrail_certificate = 'puppet:///modules/papertrail/papertrail.crt',
  $extra_logs             = [],
  $template               = 'papertrail/rsyslog.conf.erb',
) {
  include papertrail::common

  case $::os['release']['major'] {
    /^(1[6-9]|2\d)\.\d\d$/: { include papertrail::systemd }
    default: { include papertrail::upstart }
  }
}
