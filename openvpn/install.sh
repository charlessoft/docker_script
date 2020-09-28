#!/bin/bash

if [ ! -f "lzo-2.10.tar.gz" ]; then

    wget -c http://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz
    wget -c https://swupdate.openvpn.org/community/releases/openvpn-2.3.14.tar.gz
    wget -c https://github.com/OpenVPN/easy-rsa/archive/master.zip
fi


function install_lzo()
{
    tar zxvf lzo-2.10.tar.gz && \
        cd lzo-2.10 && \
        ./configure && make && make install
    cd ..
}

function install_openvpn()
{
    echo ${PWD}
    echo "======"
    tar zxvf openvpn-2.3.14.tar.gz && \
        cd openvpn-2.3.14 && \
        ./configure --with-lzo-headers=/usr/local/include --with-lzo-lib=/usr/local/lib &&  \
        make && make install
}


function install_depend()
{

    yum install unzip openssl openssl-devel pam-devel -y
}

function install_easy_rsa()
{
    unzip master.zip  && \
        mv easy-rsa-master/ easy-rsa/
}

 install_depend
 install_lzo
 install_openvpn
