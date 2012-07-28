class php::files {
  File {
    notify => Service["httpd"],
  }

  file { "/etc/php.ini":
    content => template("${module_name}/php.ini.erb")
  }

  file { "/etc/php.d/timezone.ini":
    content => template("${module_name}/timezone.ini.erb")
  }

  file { "/etc/php.d/apc.ini":
    content => template("${module_name}/apc.ini.erb")
  }
}
