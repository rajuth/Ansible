#!/bin/bash

# Install node_exporter
curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz
tar xvfz node_exporter-1.2.2.linux-amd64.tar.gz
sudo cp node_exporter-1.2.2.linux-amd64/node_exporter /usr/local/bin
rm -rf node_exporter-1.2.2.linux-amd64.tar.gz node_exporter-1.2.2.linux-amd64

# Create node_exporter service file
sudo cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# Install apache_exporter
curl -LO https://github.com/Lusitaniae/apache_exporter/releases/download/v0.9.0/apache_exporter-0.9.0.linux-amd64.tar.gz
tar xvfz apache_exporter-0.9.0.linux-amd64.tar.gz
sudo cp apache_exporter-0.9.0.linux-amd64/apache_exporter /usr/local/bin
rm -rf apache_exporter-0.9.0.linux-amd64.tar.gz apache_exporter-0.9.0.linux-amd64

# Create apache_exporter service file
sudo cat <<EOF > /etc/systemd/system/apache_exporter.service
[Unit]
Description=Apache Exporter
After=network.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/apache_exporter

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd daemon
sudo systemctl daemon-reload

# Start and enable services
sudo systemctl start node_exporter
sudo systemctl start apache_exporter
sudo systemctl enable node_exporter
sudo systemctl enable apache_exporter

