require_relative 'default_spec'

describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should_not be_enabled }
  it { should_not be_running }
end
