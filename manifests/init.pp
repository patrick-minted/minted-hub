# Copyright (C) 2015 Minted Inc.
# All Rights Reserved

class hub( $version = '2.2.0-rc1' ) {

  include wget
  include git

  file { '/usr/local/src/install_hub.sh':
    content => template('hub/install_hub.sh.erb'),
    mode    => '0755',
    owner   => root,
    group   => root,
  } ~>

  exec { 'install_hub':
    cwd         => '/usr/local/src',
    command     => '/usr/local/src/install_hub.sh',
    refreshonly => true,
  }

}
