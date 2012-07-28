class php::perconamysql {
  package { "php-mysql":
    ensure => installed,
    require => [ Package["php-cli"], Class["Percona"] ],
  }
}
