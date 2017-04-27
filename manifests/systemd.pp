class papertrail::systemd {
  file { 'remote_syslog config':
    ensure  => $remote_syslog_file,
    content => template('papertrail/log_files.yml.erb'),
    path    => '/etc/log_files.yml',
    notify  => Service['remote_syslog']
  }

  file { "/tmp/remote-syslog2_0.18_amd64.deb":
    owner   => root,
    group   => root,
    mode    => 644,
    ensure  => present,
    source  => "puppet:///modules/papertrail/remote-syslog2_0.18_amd64.deb"
  }

  package { "remote_syslog":
   provider => dpkg,
   ensure   => latest,
   source   => "/tmp/remote-syslog2_0.18_amd64.deb",
   require     => File['/tmp/remote-syslog2_0.18_amd64.deb'],
  }

  service { 'remote_syslog':
    ensure      => running,
    provider    => 'systemd',
    require     => Package['remote_syslog'],
  }

  service { 'rsyslog':
    ensure => running,
    provider => 'systemd'
  }
}
