class ius {
  yumrepo { "EPEL":
    baseurl => "http://download.fedoraproject.org/pub/epel/5/\$basearch",
    descr => "EPEL Repo",
    enabled => 1,
    gpgcheck => 0,
  }

  yumrepo { "IUS":
    baseurl => "http://dl.iuscommunity.org/pub/ius/stable/Redhat/5/\$basearch",
    descr => "IUS Community repository",
    enabled => 1,
    gpgcheck => 0
  }
}
