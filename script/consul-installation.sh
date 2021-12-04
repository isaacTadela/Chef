#!/bin/bash
 wget https://releases.hashicorp.com/consul/1.10.4/consul_1.10.4_linux_amd64.zip
 unzip consul_1.10.4_linux_amd64.zip
 rm consul_1.10.4_linux_amd64.zip
 sudo mv consul /usr/local/bin/
