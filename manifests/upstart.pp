class papertrail::upstart {
  file { 'remote_syslog config':
    ensure  => $remote_syslog_file,
    content => template('papertrail/log_files.yml.erb'),
    path    => '/etc/log_files.yml',
    require => File['remote_syslog upstart script'],
    notify  => Service['remote_syslog'],
  }

  service { 'rsyslog':
    ensure => running,
  }

  file { 'remote_syslog binary':
    ensure => file,
    source => 'puppet:///modules/papertrail/remote_syslog-0.16-i386',
    path   => '/usr/local/bin/remote_syslog',
  }

  file { 'remote_syslog upstart script':
    ensure => file,
    source => 'puppet:///modules/papertrail/remote_syslog.upstart.conf',
    path   => '/etc/init/remote_syslog.conf',
  }

  service { 'remote_syslog':
    ensure      => $remote_syslog_status,
    provider    => 'upstart',
    require     => File['remote_syslog upstart script'],
  }
}
