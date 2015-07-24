#
# Wildfly startup service class
#
class wildfly::service(
  $init_source = "${::wildfly::dirname}/bin/init.d/${::wildfly::service_file}",
  $manage_config = true,
) {

  if $manage_config {
    file { $::wildfly::conf_file:
      ensure  => present,
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
      content => template('wildfly/wildfly.conf.erb'),
      notify  => Service[$::wildfly::service_name]
    }
  }

  file { "/etc/init.d/${::wildfly::service_name}":
    ensure => present,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
    source => $init_source,
  }

  service { $::wildfly::service_name:
    ensure     => true,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => [File["/etc/init.d/${::wildfly::service_name}"], File[$::wildfly::conf_file]]
  }

}
