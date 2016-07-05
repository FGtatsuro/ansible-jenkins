require 'rake'
require 'rspec/core/rake_task'

task :spec    => 'spec:all'
task :default => :spec

namespace :spec do
  hosts = [
    {
      :name     =>  'localhost',
      :backend  =>  'exec',
      :jenkins_war_path => '/usr/local/opt/jenkins/libexec/jenkins.war'
    },
    {
      :name     =>  'container',
      :backend  =>  'docker',
      :jenkins_home => '/var/lib/jenkins',
      :jenkins_war_path => '/opt/jenkins/jenkins.war',
      :jenkins_user_login_shell => '/sbin/nologin'
    }
  ]
  if ENV['SPEC_TARGET'] then
    target = hosts.select{|h|  h[:name] == ENV['SPEC_TARGET']}
    hosts = target unless target.empty?
  end

  task :all     => hosts.map{|h|  "spec:#{h[:name]}"}
  task :default => :all

  hosts.each do |host|
    desc "Run serverspec tests to #{host[:name]}(backend=#{host[:backend]})"
    RSpec::Core::RakeTask.new(host[:name].to_sym) do |t|
      ENV['TARGET_HOST'] = host[:name]
      ENV['SPEC_TARGET_BACKEND'] = host[:backend]
      ENV['JENKINS_HOME'] = host[:jenkins_home] || nil
      ENV['JENKINS_VERSION'] = '1.656'
      ENV['JENKINS_WAR_PATH'] = host[:jenkins_war_path]
      ENV['JENKINS_USER_LOGIN_SHELL'] = host[:jenkins_user_login_shell] || nil
      t.pattern = "spec/jenkins_spec.rb"
    end
  end
end
