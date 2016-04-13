ansible-jenkins
====================================

[![Build Status](https://travis-ci.org/FGtatsuro/ansible-jenkins.svg?branch=master)](https://travis-ci.org/FGtatsuro/ansible-jenkins)

Ansible role for Jenkins.

Requirements
------------

The dependencies on other softwares/librarys for this role.

- Debian
- Alpine Linux
- OSX
  - Homebrew (>= 0.9.5)

Role Variables
--------------

The variables we can use in this role.

|name|description|default|
|---|---|---|
|jenkins_home|Home directory of Jenkins. You should also set this value as environment `JENKINS_HOME`.|/var/lib/jenkins|
|jenkins_war_dir|Parent directory Jenkins war file is put. In default, path of Jenkins war file is `/opt/jenkins/jenkins.war`.|/opt/jenkins|
|jenkins_download_url|Download URL for Jenkins war file. Different version has different URL.|https://updates.jenkins-ci.org/download/war/1.656/jenkins.war|
|jenkins_sha256|SHA256 signature of Jenkins war file. This is used for idempotency.|97085359725b16aca0f419486e5c1809399e33dbe6d906cd55ef82fad76fb30d|

Role Dependencies
-----------------

The dependencies on other roles for this role.

- FGtatsuro.python-requirements
- FGtatsuro.java
- FGtatsuro.postfix

Example Playbook
----------------

    - hosts: all
      roles:
         - { role: FGtatsuro.jenkins }

Test on local Docker host
-------------------------

This project run tests on Travis CI, but we can also run them on local Docker host.
Please check `install`, `before_script`, and `script` sections of `.travis.yml`.
We can use same steps of them for local Docker host.

Local requirements are as follows.

- Ansible (>= 2.0.0)
- Docker (>= 1.10.1)

License
-------

MIT
