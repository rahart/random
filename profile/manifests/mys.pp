class profile::mys {
  class { 'mysql::server':
    root_password    => 'UNBROKEN',
    override_options => { 'mysqld' => { 'max_connections' => '1024' } }
  }
  class{ 'mysql::client': }
  mysql::db { 'jamwiki':
    user     => 'jammer',
    password => 'JAMMER',
    host     => 'localhost',
    grant    => ['ALL'],
  }

  package { 'libmysql-java':
    ensure => 'present',
  }
}
