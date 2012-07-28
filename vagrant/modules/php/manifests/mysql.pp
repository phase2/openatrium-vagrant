class php::mysql {
  package { "php-mysql":
    ensure => installed,
    require => Package["php-cli"],
  }

  package { "mysql":
    ensure => installed,
    require => Package["php-mysql"],
  }
}

