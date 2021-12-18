vault {
 # Specified via the environment variable VAULT_ADDR, This is the address of the Vault leader.
 # address      = "http://$MASTER_IP:8200"
 # Specified via the environment variable VAULT_TOKEN, This is the token of the Vault leader.
 # token        = "root"
 default_lease_duration = "60s"

 unwrap_token = false
 renew_token  = false
 }

syslog {
  enabled  = true
  facility = "LOCAL5"
}

 consul {
  # This can be specified via the environment variable CONSUL_HTTP_ADDR, This is the address of the Consul server.
  address = "$MASTER_PUBLIC_IP:8500"

  auth {
    enabled = true
    username = "test"
    password = "test"
  }
 }

 log_level = "warn"

 # render the role with the new version value, temporary aws credentials and re run chef-solo
 template {
  source = "/home/Chef/script/consul-mysql-npm-role.tpl"
  destination = "/home/Chef/roles/consul-mysql-npm.json"
   exec {
     command = "sudo chef-solo -c /home/Chef/solo.rb -j /home/Chef/runlist.json > /home/logs/chef-consul-template.log 2>&1"
   }
 }

