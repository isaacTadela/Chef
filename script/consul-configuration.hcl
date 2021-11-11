vault {
 # This is the address of the Vault leader.
 address      = "http://$MASTER_IP:8200"
 
 # This value can also be specified via the environment variable VAULT_TOKEN.
 token        = "root"
 
 unwrap_token = false 
 renew_token  = false
 }
  
 consul {
  address = "$MASTER_IP:8500"
 
  auth {
    enabled = true
    username = "test"
    password = "test"
  }
 }
  
 log_level = "warn"
 
 # render the role with the new value and re run chef-solo 
 template {
  source = "/home/ubuntu/Chef/script/consul-mysql-npm-role.tpl"
  destination = "/home/ubuntu/Chef/roles/consul-mysql-npm.json"
   exec {
     command = "sudo chef-solo -c /home/ubuntu/Chef/solo.rb -j /home/ubuntu/Chef/runlist.json > /home/ubuntu/consul-template.log "
   }
 }
