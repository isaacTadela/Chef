{
  "name": "consul-mysql-npm",
  "override_attributes": {
    "consul-mysql-npm": {
      "version": "Vers.erb",
      "attr1": {
        "name": "{{ key "/version" }}"
      }
    }
  },
  "run_list": [
    "recipe[consul-mysql-npm]"
  ]
 }
