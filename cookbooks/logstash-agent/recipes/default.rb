# logstash agent

# requires Java runtime environment

# run apt-get update

execute "apt-get update" do
  command "apt-get update"
  ignore_failure true
  action :run
end

# install java
package "openjdk-7-jre" do
  action :install
end

# create users
user "logstash" do
  home "/opt/logstash-#{node[:logstash][:version]}/"
  shell "/bin/bash"
end

# create directories

directory "/opt/logstash-#{node[:logstash][:version]}/" do
  user 'logstash'
  group 'logstash'
  mode '0755'
end

directory "/etc/logstash-#{node[:logstash][:version]}/" do
  user 'logstash'
  group 'logstash'
  mode '0755'
end

directory "/var/log/logstash-agent/" do
  user 'logstash'
  group 'logstash'
  mode '0755'
end

# install logstash package

bash 'install logstash' do
  not_if {File.exists?("/opt/logstash-#{node[:logstash][:version]}/bin/logstash.bat")} #maintain idempotency if files already exists
  user "root"
  cwd "/opt/"
  code <<-EOH
    wget https://download.elasticsearch.org/logstash/logstash/logstash-#{node[:logstash][:version]}.tar.gz
    tar -zxf logstash-#{node[:logstash][:version]}.tar.gz
    mv logstash-#{node[:logstash][:version]}.tar.gz /tmp/
  EOH
end

# install additional application server packages to test

# apache

package "apache2" do
  action :install
end

# Glassfish

# add install of glassfish here


# configuration files

# Logstash agent config

template "/etc/logstash-#{node[:logstash][:version]}/agent.conf" do
  user 'logstash'
  group 'logstash'
  mode '0644'
  #notifies :restart, 'service[logstash]'   #(this tells service to restart if config changes)
end
