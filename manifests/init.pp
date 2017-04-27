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

  $remote_syslog_status = empty($extra_logs) ? {
    true => stopped,
    false  => running
  }

  $remote_syslog_file = empty($extra_logs) ? {
    true => absent,
    false  => file
  }

  include papertrail::common

  case $::os['release']['major'] {
    /^(1[6-9]|2\d)\.\d\d$/: { include papertrail::systemd }
    default: { include papertrail::upstart }
  }
}
