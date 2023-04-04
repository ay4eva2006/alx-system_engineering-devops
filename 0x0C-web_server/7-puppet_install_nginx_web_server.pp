# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Configure Nginx server
file { '/etc/nginx/sites-available/default':
  content => template('nginx/default.erb'),
  notify  => Service['nginx'],
}

# Configure Nginx default page
file { '/var/www/html/index.html':
  content => 'Hello World!',
}

# Redirect /redirect_me to another page using a 301 redirect
nginx::resource::server { 'default':
  listen_port => 80,
  server_name => 'localhost',
  locations   => {
    '/redirect_me' => {
      ensure       => present,
      www_redirect => 'permanent',
      rewrite_to   => 'https://www.example.com',
    },
  },
}

# Ensure Nginx service is running
service { 'nginx':
  ensure => running,
}

