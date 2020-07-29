#!/bin/bash
sudo firewall-cmd --permanent --list-port | grep " " | wc -w
