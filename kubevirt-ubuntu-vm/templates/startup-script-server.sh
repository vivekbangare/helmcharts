#!/bin/bash
echo "******************************"
echo "Custom script for iperf server!"
echo "******************************"

echo $(hostname -I | cut -d\  -f1) $(hostname) | sudo tee -a /etc/hosts
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null


echo "ubuntu:ubuntu" | chpasswd

echo "-----------------------"
echo "updating machine"
echo "-----------------------"
sudo apt update
echo "-----------------------"
echo "Installing iperf"
echo "-----------------------"
sudo apt install iperf
echo "-----------------------"
echo "Opening ports"
echo "-----------------------"
sudo ufw allow from any to any port 5000:5009 proto tcp
sudo ufw allow from any to any port 5000:5009 proto udp
echo "-----------------------"
echo "Iperf server as service"
echo "-----------------------"
echo '[Unit]
Description=iperf server
After=syslog.target network.target auditd.service

[Service]
ExecStart=/usr/bin/iperf -s

[Install]
WantedBy=multi-user.target' | sudo tee -a /etc/systemd/system/iperf.service

sudo systemctl enable iperf
sudo systemctl start iperf
sudo systemctl status iperf
echo "-----------------------"
echo "Done...!"
echo "-----------------------"

#for p in $(seq 9200 9240); do sudo systemctl enable iperf.service@$p;done
