#!/bin/bash
 wget https://releases.hashicorp.com/consul-template/0.27.0/consul-template_0.27.0_linux_amd64.zip
 unzip consul-template_0.27.0_linux_amd64.zip
 rm consul-template_0.27.0_linux_amd64.zip
 sudo mv consul-template /usr/local/bin/
