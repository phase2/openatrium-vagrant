class php {
  include php::packages
  include php::files

  Class["php::packages"] -> Class["php::files"]
}
