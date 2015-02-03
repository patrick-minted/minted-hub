require 'beaker-rspec'

# Install Puppet
foss_opts = { :default_action => 'gem_install' }

install_puppet( foss_opts )

hosts.each do |host|
  on host, "mkdir -p #{host['distmoduledir']}"
end

RSpec.configure do |c|
  # Root Project
  project_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
    hosts.each do |host|
      copy_module_to(host, :source => project_root, :module_name => 'hub')
      shell("/bin/touch #{default['puppetpath']}/hiera.yaml")
      on host, puppet('module install puppetlabs-stdlib --version 4.3.2'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module install maestrodev-wget --version 1.5.5'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module install puppetlabs-git --version 0.3.0'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
