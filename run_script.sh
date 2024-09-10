#!/bin/bash
sudo apt update
sudo apt install openjdk-11-jre-headless -y
wget https://www.nextgen.com/~/media/Files/NextGen-Connect/Mirth-Connect/Mirth-Connect-Latest.tar.gz
tar -xzf Mirth-Connect-Latest.tar.gz
cd MirthConnect