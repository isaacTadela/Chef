#!/bin/bash

wget https://releases.hashicorp.com/consul/1.10.4/consul_1.10.4_linux_amd64.zip
unzip consul_1.10.4_linux_amd64.zip
rm consul_1.10.4_linux_amd64.zip
sudo mv consul /usr/local/bin/

# Configure client agent as system service
echo "[Unit]
Description=HashiCorp Consul Client - A service mesh solution
Requires=network-online.target
After=network-online.target
Documentation=https://www.consul.io/
[Service]
EnvironmentFile=-/etc/sysconfig/consul
Restart=on-failure
ExecStart=/usr/local/bin/consul agent -retry-join $MASTER_IP -data-dir=/var/lib/consul -config-dir=/etc/consul.d -bind=0.0.0.0 -datacenter=my_dc -client=0.0.0.0 -advertise $MASTER_IP
ExecReload=/bin/kill -HUP $MAINPID
LimitNOFILE=65536
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/consul.service


sudo mkdir /etc/consul.d
sudo cp /home/Chef/script/web.json /etc/consul.d

