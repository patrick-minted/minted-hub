# Copyright (C) 2015 Minted Inc.
# All Rights Reserved

class hub::install(
  $version = $hub::version,
  $srcdir  = '/usr/local/src',
  $arch    = 'debian'
) {

  wget::fetch{'retrieve_hub_tarball':
    source      =>
      "https://github.com/github/hub/releases/download/v${version}/hub-linux-${arch}-${version}.tar.gz",
    destination => "${srcdir}/hub-linux-${arch}-${version}.tar.gz",
    verbose     => false,
    timeout     => 0,
    cache_dir   => '/var/cache/wget',
    cache_file  => "hub-linux-${arch}-${version}.tar.gz"
  }

  exec{'untar_hub_file':
    command => "tar -xvzf ${srcdir}/hub-linux-${arch}-${version}.tar.gz",
    path    => ['/bin','/usr/bin','/usr/local/bin'],
    creates => "${srcdir}/hub_linux_${arch}_${version}",
    require => Wget::Fetch['retrieve_hub_tarball'],
    cwd     => $srcdir
  }

  file{'/etc/bash_completion.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755'
  }

  file{'/etc/bash_completion.d/hub.bash_completion.sh':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => "${srcdir}/hub_${version}_linux_${arch}/etc/hub.bash_completion.sh",
    require => [
      Exec['untar_hub_file'],
      File['/etc/bash_completion.d']
    ]
  }

  file{'/usr/local/bin/hub':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => "${srcdir}/hub_${version}_linux_${arch}/hub",
    require => Exec['untar_hub_file']
  }

}
