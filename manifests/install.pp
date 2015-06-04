#
# wildfly install class
#
class wildfly::install  {

  archive { "wildfly-${wildfly::version}":
    url              => $wildfly::install_source,
    target           => $wildfly::dirname,
    strip_components => 1
  }
  ->
  file { $wildfly::dirname:
    ensure  => directory,
    user    => $wildfly::user,
    group   => $wildfly::group,
    recurse => true
  }

}
