class profile::ngx {
  class { 'nginx': }
  nginx::resource::vhost { 'jamwiki.travisharrington.com':
    proxy => 'http://localhost:8080',
  }
}
