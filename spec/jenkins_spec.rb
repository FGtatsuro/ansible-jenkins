require "spec_helper_#{ENV['SPEC_TARGET_BACKEND']}"

describe package('jenkins'), :if => os[:family] == 'darwin' do
  it { should be_installed }
end

describe command("java -jar #{ENV['JENKINS_WAR_PATH']} --version"), :if => os[:family] == 'darwin' do
  # On OSX, it's difficult to check specified version because Homebrew installs latest one.
  its(:exit_status) { should eq 0 }
end

describe command("java -jar #{ENV['JENKINS_WAR_PATH']} --version | tail -n 1"), :if => ['debian', 'alpine'].include?(os[:family]) do
  its(:stdout) { should contain(ENV['JENKINS_VERSION']) }
end

describe user('jenkins'), :if => ['debian', 'alpine'].include?(os[:family]) do
  it { should belong_to_group 'jenkins' }
end

describe user('jenkins'), :if => ['debian', 'alpine'].include?(os[:family]) do
  it { should have_home_directory ENV['JENKINS_HOME'] }
end

describe user('jenkins'), :if => ['debian', 'alpine'].include?(os[:family]) do
  it { should have_login_shell '/bin/sh' }
end

describe user('jenkins'), :if => ['debian', 'alpine'].include?(os[:family]) do
  its(:encrypted_password) { should eq "$6$rounds=656000$jenkinsrolegene$NH3.2ots3RJ3wK2xqZgH.R13qW9Q4DV0efbjcijs7ogwNLs0HWB5sq1oCMiswEFbiitIO.B5ZvesPNNPcez/K/" }
end
