require 'spec_helper'

describe 'hub', :type => :class do
  let(:params){{
    :version => '1.2.3',
    }}

  it { should contain_class('hub::install') }
  it { should contain_class('git')}
  it { should contain_class('wget')}
end
