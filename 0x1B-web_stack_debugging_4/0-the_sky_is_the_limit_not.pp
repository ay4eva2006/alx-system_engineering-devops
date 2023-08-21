#:wqsky is the limit, let's bring that limit higher

exec { 'increase-ulimit':
  command => 'sed -i "s/15/4096/" /etc/default/nginx',
  path    => ['/usr/local/bin/', '/bin/'],
}

exec { 'restart-nginx':
  command => 'nginx restart',
  path    => ['/etc/init.d/'],
}
