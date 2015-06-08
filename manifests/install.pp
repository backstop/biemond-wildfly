#
# wildfly install class
#
class wildfly::install  {

  archive::download { "wildfly-${wildfly::version}.tar.gz":
    ensure           => present,
    url              => $wildfly::install_source,
    checksum         => false
  }
  ~>
  exec { 'Unpack wildfly':
    command     => "mkdir -p ${wildfly::dirname} && tar --no-same-owner --no-same-permissions -xzf /usr/src/wildfly-${wildfly::version}.tar.gz -C ${wildfly::dirname} --strip-components=1 && chown -R ${wildfly::user}:${wildfly::group} ${wildfly::dirname}",
    refreshonly => true
  }
}
