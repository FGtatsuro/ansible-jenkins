require "spec_helper_#{ENV['SPEC_TARGET_BACKEND']}"

describe package('jenkins'), :if => os[:family] == 'darwin' do
  it { should be_installed }
end

describe command("java -jar /usr/local/opt/jenkins/libexec/jenkins.war --version | tail -n 1") :if => os[:family] == 'darwin' do
  its(:exit_status) { should eq 0 }
end

describe command("java -jar #{ENV['JENKINS_WAR_PATH']} --version | tail -n 1"), :if => ['debian', 'alpine'].include?(os[:family]) do
  its(:stdout) { should contain(ENV['JENKINS_VERSION']) }
end
