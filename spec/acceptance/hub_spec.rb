require 'spec_helper_acceptance'

describe 'hub class' do

  it 'should work with no errors' do
    pp = <<-EOS
    class { 'hub':
      version => '2.2.0-rc1',
    }
    EOS

    apply_manifest(pp, :catch_failures => true)
  end

  it 'should be installed' do
    shell('/usr/local/bin/hub --version')
  end
end
