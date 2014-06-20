class profile::ngx {
  class { 'nginx': }
  nginx::resource::vhost { 'jamwiki.utilize.io':
    proxy => 'http://localhost:8080',
  }
}
