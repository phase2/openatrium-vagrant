class vagrant {
  # Specific tweaks that we envision will only be necessary for the purpose of running
  # Vagrant VMs. Normally, try to use $environment if there's a file that needs to be
  # different among the various environments (dev, stage, QA, production.)

  # @TODO: Break this up into sub-modules?

  # Prevent an error in Puppet 2.7 with `puppet apply` when the puppet user
  # and group do not exist.
  group { "puppet":
    ensure => present,
    gid => 24,
  }

  user { "puppet":
    ensure => present,
    uid => 24,
    gid => 24,
    home => "/var/lib/puppet",
    managehome => true,
    require => Group["puppet"],
  }

  # We don't want no stinkin' iptables on our locals.
  service { "iptables" :
    ensure => stopped,
    enable => false,
    hasstatus => true,
  }

  # Open up httpd log directory access for easy viewing.
  file { "/var/log/httpd":
    mode => "0755",
    #require => Class["apache"],
  }

  # What Vagrant project would be complete without an ASCII art motd?
  file { "/etc/motd":
   owner => 0,
   group => 0,
   mode => 0644,
   content => "
                             `+-`                                                        
                            ./ys+:                                                       
                            -yyyyyo:.                      ``.---.                       
                           -+yyyyyyyo/`                 `.-::::::-                       
                           +yyyyyyyyyyo/.`            .-::::::::::                       
                          :oyyyyyyyyyyyys+.`       `.:////::::::::                       
                          syyyyyyyyyyyyyyys+-`    `-/////////:::::        ```..--------. 
                        `-yyyyyyyyyyyyyyyyyyso-`  -/++/////////:::    `..-:::::::::::::. 
                        -oyyyyyyyyyyyyyyyyyyyyy+:.++++++////////:- `.-:::::::::::::::::` 
                       ./yyyyyyyyyyyyyyyyyyyyyyyysoo+++++++/////:--:::::::::::::::::::-` 
                       /syyyyy+oosyyyyyyyyyyyyyyyyyyso++++++++/////////:::::::::::::::.` 
                      .oyyyyyo::://osyyyyyyyyyyyyyyyyysoo+++++++/////////:::::::::::::`  
                      +syyyys/:::::://syyyyyyyyysssyyyyyso+++++++++/////////::::::::-.   
                     `yyyyyyo:::::::///oyyysso+++++syyyyyysoo++++++++/////////::::::.    
                    ./yyyyyyo::::///////+so++++++++osyyyyyyyyso++++++++//////////:-`     
                   `:yyyyyyyo://///////+++++++++++oosyyyyyyyyyysoo++++++++//////:-`      
                   -+yyyyyyys////////+++++++++oooooosyyyyyyyyyyyysoo+++++++++//-.        
                  `+yyyyyyyys+///++++++++++oooooooossyyyyyyyyyyyyyysoo++++//:-`          
                  :syyyyyyyyys+++++++++oooooooooosssyyyyyyyyyyyyssssoooo++-`             
                  sys/++++++oo+++++++ooooooooosssssyyyyyyyyssssssssooooooo+/-`           
          -://+///yys///++++++++++ooooooooossssssssssssssssssssssssssoooooooo+:.         
       .:oyyyyyyyyyys+++++++++oooooooooossssssssssssssssssssssssssssssssooooooo+:.       
      .+yyyso+/+oyyyys+++++oooooooooosssssssssssssssssssssssssssssssssssssooooooo+.`     
      oyyy+-`   `.syyyoooooooooooosssssssssssssssssssssssssssssssssssssssssssoo+/:`      
      yyyy.`      /syyysoooooossssssssssssssssssssssssssssssssssssssssssssso+/-.`        
      syyy:.     `oyyyyyssssssssssyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyysso+/::..`            
      /syyy+:-.-:+yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyys:`                
       -+yyyyyyyyyyyyhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhs:                
        `.+syyyyhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhs/               
          :syhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhyy-`             
        `.yyhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhs:`            
       `-shhhhhhhhhhhhyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyhhhhhhhhhhhs/`           
       :ohhhhhhhhhhhys.........................................+yhhhhhhhhhhhs/           
      :shhhhhhhhhhhyo.                                         ./yhhhhhhhhhhhy-`         
    `.yyhhhhhhhhhhh+-                                           ./hhhhhhhhhhhhy:`        
   `:shhhhhhhhhhhh+.                                              +yhhhhhhhhhhhs/`       
   :ohhhhhhhhhhhys`                                               `+yhhhhhhhhhhhs+       
  /shhhhhhhhhhhy+.                                                 `:yhhhhhhhhhhhh:`     
`-yhhhhhhhhhhhh+-                                                   `:hhhhhhhhhhhhy:`    
`:////////////:`                                                      :////////////:.    

Welcome to an OpenAtrium VM managed by Vagrant.\n\n",
  }

  # Cache yum files on the hosts's disk. This will speed up building the box
  # from scratch.
  file_line { "yum_cachedir":
    line => "cachedir=/vagrant/scratch/yum/\$basearch/\$releasever",
    path => "/etc/yum.conf",
  }
}
