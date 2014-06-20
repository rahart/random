class profile::tomcat {
  package {'openjdk-7-jdk':
    ensure => 'present',
  }->
  group { 'tomcat':
    ensure => present,
    gid    => 8001,
  } ->
  user { 'tomcat':
    ensure   => present,
    password => 'X',
    uid      => '8001',
    gid      => '8001',
    groups   => 'tomcat',
    home     => '/home/tomcat',
    shell    => '/bin/false',
  } ->
  exec {'/usr/bin/wget -P /opt/ http://mirror.symnds.com/software/Apache/tomcat/tomcat-7/v7.0.54/bin/apache-tomcat-7.0.54.tar.gz':
    creates => "/opt/apache-tomcat-7.0.54.tar.gz", 
  }->
  exec {'/bin/tar xvfz /opt/apache-tomcat-7.0.54.tar.gz -C /opt/':
    creates => "/opt/apache-tomcat-7.0.54",
  }
  file { [ "/opt/apache-tomcat-7.0.54/webapps/docs", "/opt/apache-tomcat-7.0.54/webapps/examples", "/opt/apache-tomcat-7.0.54/webapps/host-manager", "/opt/apache-tomcat-7.0.54/webapps/manager"]:
    ensure => absent,
    force  => true,
  } ->
  file {['/opt/jamwiki-app', '/opt/jamwiki']:
    ensure => directory,
  } ->
  exec {'/usr/bin/wget -P /opt/jamwiki-app http://downloads.sourceforge.net/jamwiki/jamwiki-1.3.2.war':
    creates => "/opt/jamwiki-app/jamwiki-1.3.2.war",
  } ->
  file {'/opt/apache-tomcat-7.0.54/bin/setenv.sh':
    ensure  => 'file',
    content => 'CLASSPATH=/usr/share/java/mysql.jar',
  } 
}
