#!/bin/bash
echo "******************************"
echo "Custom script for iperf client!"
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