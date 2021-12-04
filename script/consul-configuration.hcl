  node_name = "EC2 node"
  server     = false
  datacenter = "my_dc"
  data_dir = "/temp/consul"
  log_level  = "INFO"
  retry_join = [ "$MASTER_IP" ]
  addresses {
    http = "$MASTER_IP",
    http = "0.0.0.0"
  }
  connect {
    enabled = true
  }

service = {
  name = "web"
  tags = ["my-website"]
  port = 80

  check = {
    name = "web_health_status"
    http = "http://localhost:80/"
    method = "GET"
    interval = "10s"
    timeout = "1s"
  }
}
