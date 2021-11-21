{
  "name": "consul-mysql-npm",
  "override_attributes": {
    "consul-mysql-npm": {
      "version": "Vers.erb",
      "attr1": {
        "name": "{{ key "/version" }}",
        "access_key": "{{ with secret "aws/creds/dev-admin-role" }}{{ .Data.access_key }}{{ end }}",
        "secret_key": "{{ with secret "aws/creds/dev-admin-role" }}{{ .Data.secret_key  }}{{ end }}"
      }
    }
  },
  "run_list": [
    "recipe[consul-mysql-npm]"
  ]
 }
