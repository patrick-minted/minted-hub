require 'spec_helper'

describe 'hub::install' do
  context('with default params') do
    let(:params){{
      :version  => nil
    }}

    it { should contain_wget__fetch('retrieve_hub_tarball')}
    it { should contain_exec('untar_hub_file') }
    it { should contain_file(
      '/etc/bash_completion.d/hub.bash_completion.sh'
      )
    }
    it { should contain_file('/usr/local/bin/hub')}
  end

  context('with good params') do
    let(:params){{
      :version  => '1.2.3',
      :srcdir   => '/tmp',
      :arch     => 'debian'
    }}

    it { should contain_wget__fetch('retrieve_hub_tarball'
      ).with(
        :source      => 'https://github.com/github/hub/releases/download/v1.2.3/hub-linux-debian-1.2.3.tar.gz',
        :destination => '/tmp/hub-linux-debian-1.2.3.tar.gz',
        :verbose     => false,
        :timeout     => 0,
        :cache_dir   => '/var/cache/wget',
        :cache_file  => 'hub-linux-debian-1.2.3.tar.gz'
      )
    }
    it { should contain_exec('untar_hub_file').with(
        :command => 'tar -xvzf /tmp/hub-linux-debian-1.2.3.tar.gz',
        :creates => '/tmp/hub_linux_debian_1.2.3',
        :require => 'Wget::Fetch[retrieve_hub_tarball]',
        :cwd     => '/tmp'
      )
    }
    it { should contain_file('/etc/bash_completion.d').with(
        :ensure => 'directory',
        :owner  => 'root',
        :group  => 'root',
        :mode   => '0755',
      )
    }
    it { should contain_file(
      '/etc/bash_completion.d/hub.bash_completion.sh'
      ).with(
        :ensure  => 'file',
        :owner   => 'root',
        :group   => 'root',
        :mode    => '0755',
        :source  => '/tmp/hub_1.2.3_linux_debian/etc/hub.bash_completion.sh',
        :require => ['Exec[untar_hub_file]','File[/etc/bash_completion.d]']
      )
    }
    it { should contain_file('/usr/local/bin/hub').with(
        :ensure  => 'file',
        :owner   => 'root',
        :group   => 'root',
        :mode    => '0755',
        :source  => '/tmp/hub_1.2.3_linux_debian/hub',
        :require => 'Exec[untar_hub_file]'
      )
    }
  end
end
