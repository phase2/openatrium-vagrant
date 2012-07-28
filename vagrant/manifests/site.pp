node default {
  # Include some recommended vagrant tweaks.
  include vagrant

  # Install Apache and set up a vhost.
  include apache
  apache::vhost { "local.openatrium.com":
    priority    => "10",
    port        => "80",
    docroot     => "/var/www/vhosts/openatrium.com",
    template    => "openatrium/vhost-openatrium.conf.erb",
  }

  # Include the IUS repository.
  include ius

  # Include MySQL 5.5 from IUS.
  class { "mysql::server":
    config_hash => {
      "root_password" => "openatrium"
    },
    service_name => "mysqld",
    package_name => "mysql55-server",
  }

  # Create a database for our application.
  mysql::db { "openatrium":
    user     => "openatrium",
    password => "openatrium",
    host     => "localhost",
    grant    => ["all"],
  }

  # Include php and drush.
  include php
  include drush

  # Install htop, a great process viewer.
  include htop

  # Put dependencies in order.
  Class["ius"] -> Class["mysql::server"] -> Class["php"]
}
