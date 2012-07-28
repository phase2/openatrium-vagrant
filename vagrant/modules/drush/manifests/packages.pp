class drush::packages {
  # Upgrade PEAR to 1.9.2+ so it can use pear.drush.org without complaint.
  pear::package { "PEAR": }
  pear::package { "Console_Table": }

  # Version numbers are supported.
  # Also, make sure PEAR is upgraded before trying to install drush.
  pear::package { "drush":
    version => "4.5.0",
    repository => "pear.drush.org",
    require => [ Pear::Package["PEAR"], Pear::Package["Console_Table"] ],
  }
}
