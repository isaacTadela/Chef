#!/bin/bash

wget https://releases.hashicorp.com/consul/1.10.4/consul_1.10.4_linux_amd64.zip
unzip consul_1.10.4_linux_amd64.zip < "/dev/null"
rm consul_1.10.4_linux_amd64.zip
sudo mv consul /usr/local/bin/


export MY_PUBLIC_IP=$(curl ifconfig.me)
echo "MY_PUBLIC_IP=$MY_PUBLIC_IP" | sudo tee -a /etc/environment

mkdir /home/logs/
mkdir /etc/consul.d/

# Consul agent configuration
echo "{
  \"datacenter\": \"my_dc\",
  \"retry_join\": [ \"$MASTER_PUBLIC_IP\" ],
  \"data_dir\": \"/tmp/consul\",
  \"log_level\": \"DEBUG\",
  \"server\": false,
  \"leave_on_terminate\": false,
  \"enable_script_checks\":true,
  \"client_addr\": \"0.0.0.0\",
  \"log_file\": \"/home/logs/consul.log\",
  \"log_rotate_max_files\": 2
} " > /etc/consul.d/consul.json


# Consul agent service check
echo "{
   \"service\": {
   \"name\": \"$MY_PUBLIC_IP\",
   \"tags\": [
     \"my-website\"
    ],
   \"port\": 80,
   \"check\": {
     \"name\": \"$MY_PUBLIC_IP\",
     \"http\": \"http://$MY_PUBLIC_IP:80/\",
     \"method\": \"GET\",
     \"interval\": \"10s\",
     \"timeout\": \"5s\"
   }
 }
} " > /etc/consul.d/web.json

# Configure client agent as system service
echo "[Unit]
Description=HashiCorp Consul Client - A service mesh solution
Requires=network-online.target
After=network-online.target
Documentation=https://www.consul.io/
ConditionFileNotEmpty=/etc/consul.d/consul.json
[Service]
EnvironmentFile=-/etc/sysconfig/consul
ExecStart=/usr/local/bin/consul agent -config-dir=/etc/consul.d/
ExecReload=/usr/local/bin/consul reload
ExecStop=/usr/local/bin/consul leave
KillMode=process
KillSignal=SIGTERM
Restart=on-failure
LimitNOFILE=65536
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/consul.service

# Start monitor the service
sudo consul services register /etc/consul.d/web.json

# Start Cosnul
systemctl daemon-reload
systemctl enable consul.service
systemctl start consul.service
