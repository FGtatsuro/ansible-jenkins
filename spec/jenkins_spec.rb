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

# Linux default
describe user('jenkins'), :if => ['debian', 'alpine'].include?(os[:family]) do
  it { should have_home_directory '/home/jenkins' }
end

describe file(ENV['JENKINS_HOME']), :if => ['debian', 'alpine'].include?(os[:family]) do
  it { should be_directory }
end

describe user('jenkins'), :if => ['debian', 'alpine'].include?(os[:family]) do
  it { should have_login_shell '/sbin/nologin' }
end
