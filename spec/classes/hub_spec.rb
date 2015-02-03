require 'spec_helper'

describe 'hub', :type => :class do
  # Wget is included
  it { should contain_class('wget') }

  # Git Class is included
  it { should contain_class('git') }

  # Install Hub Script
  it { should contain_file('/usr/local/src/install_hub.sh').with({
    'mode'  => '0755',
    'owner' => 'root',
    'group' => 'root',
  })}

end
