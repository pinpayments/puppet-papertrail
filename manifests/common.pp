class papertrail::common {
  package { 'rsyslog-gnutls':
    ensure => installed,
    notify => Service['rsyslog'],
  }

  $remote_syslog_status = empty($extra_logs) ? {
    true => stopped,
    false  => running
  }

  $remote_syslog_file = empty($extra_logs) ? {
    true => absent,
    false  => file
  }

  file { 'rsyslog config':
    ensure   => file,
    content  => template('papertrail/rsyslog.conf.erb'),
    path     => '/etc/rsyslog.d/99-papertrail.conf',
    notify   => Service['rsyslog'],
  }

  file { 'papertrail certificate':
    ensure => file,
    source => $papertrail_certificate,
    path   => '/etc/papertrail.crt',
    notify => Service['rsyslog'],
  }
}
