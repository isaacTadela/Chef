{
  "name": "consul-mysql-npm",
  "override_attributes": {
    "consul-mysql-npm": {
      "version": "Vers.erb",
      "attr1": {
        "name": "{{ key "/version" }}",
        "access_key": "{{ with secret "aws/creds/ec2-node-role" "ttl=30s" }}{{ .Data.access_key }}{{ end }}",
        "secret_key": "{{ with secret "aws/creds/ec2-node-role" "ttl=30s" }}{{ .Data.secret_key  }}{{ end }}"
      }
    }
  },
  "run_list": [
    "recipe[consul-mysql-npm]"
  ]
 }
