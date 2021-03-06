require 'spec_helper'

describe 'w_memcached::default' do

  describe port(11211) do
    it { should be_listening.with('tcp') }
  end

  describe command('ufw status numbered') do
    its(:stdout) { should match(/Status: active/) }
    its(:stdout) { should match(%r{ 11211/tcp + ALLOW IN +Anywhere$}) }
    its(:stdout) { should match(%r{11211/tcp + ALLOW IN +Anywhere \(v6\)$}) } if os[:family] == 'ubuntu' and os[:release] == '12.04'
    its(:stdout) { should match(%r{11211/tcp \(v6\) + ALLOW IN +Anywhere \(v6\)$}) } if os[:family] == 'ubuntu' and os[:release] == '14.04'
  end

  describe package('memcached') do
    it { should be_installed }
  end

  describe service('memcached') do
    it { should be_enabled }
    it { should be_running }
  end
end
