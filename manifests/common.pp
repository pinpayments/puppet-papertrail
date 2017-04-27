class papertrail::common {
  package { 'rsyslog-gnutls':
    ensure => installed,
    notify => Service['rsyslog'],
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
