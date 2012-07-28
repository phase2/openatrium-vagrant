class php::packages {
  package { [ "php52-cli", "php52-mbstring", "php52-devel", "php52", "php52-gd", "php52-soap", "php52-xml", "php52-pdo", "php52-mysql" ]:
    ensure => installed,
  }

  package { [ "php52-pecl-memcache", "php52-pecl-apc" ] :
    ensure => installed,
    require => Package["php52-cli"],
  }

  class { "pear":
    package => "php52-pear",
  }
}
