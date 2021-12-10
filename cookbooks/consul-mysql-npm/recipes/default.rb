package 'unzip' do
  action :install
end

package 'mysql-client' do
  action :install
end
 
package 'awscli' do
  action :install
end
 
# Node.js binary distributions are available from NodeSource
# for Debian and Ubuntu based Linux distributions
# maybe i need to find another way ??
execute "Node.js binary" do
  command "curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - && sudo apt-get install -y nodejs"
end

# Install Consul agent
execute "install consul" do
  command "sh /home/Chef/script/consul-installation.sh"
  not_if "ps -A | awk '{print $4}' | grep -x consul"
end

# Install consul-template
execute "install consul-temaplte" do
  command "sh /home/Chef/script/consul-template-installation.sh"
  not_if "ls /usr/local/bin/ | grep -x consul-template"
end

# Run consul-template
execute "run consul-temaplte" do
  command "consul-template -config /home/Chef/script/consul-template-configuration.hcl > /home/consul-template.log 2>&1 &"
  not_if "ps -A | awk '{print $4}' | grep -x consul-template"
end

# Create/Update myApp-installation script
template "/home/Chef/script/myApp-installation.sh" do
  source node["consul-mysql-npm"]["version"]
  mode '0644'
end
 
bash 'run myApp-installation.sh, npm install and start' do
   cwd '/home/'
   code <<-EOH
     sh /home/Chef/script/myApp-installation.sh > /home/myApp.log
     cd /home/Unofficial-Chevrolet-Auto-shop && npm install >> /home/myApp.log
     cd /home/Unofficial-Chevrolet-Auto-shop && node server.js & >> /home/myApp.log
   EOH
end
