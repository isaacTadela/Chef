 package 'unzip' do
   action :install
 end

 package 'mysql-client' do
   action :install
 end
 
 package 'awscli' do
   action :install
 end
 
 package 'nodejs' do
   action :install
 end
 
 package 'npm' do
   action :install
 end
 
 # Create/Update myApp-installation script
 template "/home/Chef/script/myApp-installation.sh" do
   source node["consul-mysql-npm"]["version"]
   mode '0644'
 end
 
 bash 'run myApp-installation.sh' do
   cwd '/home/'
   code <<-EOH 
     sh /home/Chef/script/myApp-installation.sh > /home/myApp.log 
   EOH
 end
 
