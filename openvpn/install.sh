#!/bin/bash

mkdir -p $PWD/softs

if [ ! -f "softs/lzo-2.10.tar.gz" ]; then

    wget -c http://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz -O softs/lzo-2.10.tar.gz
    wget -c https://swupdate.openvpn.org/community/releases/openvpn-2.3.14.tar.gz -O softs/openvpn-2.3.14.tar.gz
    # wget -c https://github.com/OpenVPN/easy-rsa/archive/master.zip
    wget -c https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.8/EasyRSA-3.0.8.tgz -O softs/EasyRSA-3.0.8.tgz
fi


function install_lzo()
{
    cd softs
    tar zxvf lzo-2.10.tar.gz && \
        cd lzo-2.10 && \
        ./configure && make && make install
    cd ..
}

function install_openvpn()
{
    cd softs
    tar zxvf openvpn-2.5.8.tar.gz && \
        cd openvpn-2.5.8  \
        && autoheader \
        && aclocal \
        && libtoolize --ltdl --copy --force \
        && automake --add-missing --copy \
        && autoconf \
        && ./configure --with-lzo-headers=/usr/local/include --with-lzo-lib=/usr/local/lib &&  \
        make && make install

    cd ../..

}
# function install_openvpn()
# {
#     cd softs
#     tar zxvf openvpn-2.3.14.tar.gz && \
#         cd openvpn-2.3.14 && \
#         ./configure --with-lzo-headers=/usr/local/include --with-lzo-lib=/usr/local/lib &&  \
#         make && make install
#     unzip openvpn.zip  && \
#         cd openvpn && \
#         cd src/easylogger && \
# autoheader;aclocal;automake --add-missing;autoconf;./configure;make
#     cd openvpn && \
#         autoheader;aclocal;automake --add-missing;autoconf;
# CPPFLAGS="-DENABLE_PF -DENABLE_DEBUG" ./configure --with-lzo-headers=/usr/local/include
# make

#     cd ../..

#     mkdir /tmp/openvpn_filter
#     mkdir -p ccd
# }

CMD_LIST=( gcc \
    )

function install_ntpdate()
{
    timedatectl set-timezone Asia/Shanghai
    yum -y install ntp ntpdate
    ntpdate cn.pool.ntp.org
}

function install_depend()
{
	# for CMD in ${CMD_LIST[@]}
	# do
	# 	which ${CMD} > /dev/null 2>&1
	# 	if [ $? -eq 0 ]
	# 	then
	# 		# success "check ${CMD}"
	# 		echo "check $CMD ok"
	# 	else
	# 		echo "${CMD} no such file"
	# 		exit 1
	# 	fi
	# done
    yum install libtool-ltdl-devel -y
    yum install gcc net-tools zip unzip openssl openssl-devel pam-devel wget python3 -y
    yum install libtool perl-Thread-Queue libuuid-devel -y
    yum install http://repo.okay.com.mx/centos/7/x86_64/release/okay-release-1-1.noarch.rpm -y
    yum install automake --nogpgcheck -y
    if [ $? -eq 0 ]; then
        echo "succeed"
    else
        echo "yum download fail"
        exit 1
    fi
}

function install_easy_rsa()
{

    cd softs
    mkdir -p ${PWD}/easy-rsa && \
        tar xvf EasyRSA-3.0.8.tgz && \
        mv EasyRSA-3.0.8 easy-rsa/easyrsa3
        # ln -sf ${PWD}/EasyRSA-3.0.8 ${PWD}/easy-rsa
}

install_ntpdate
install_depend
install_lzo
install_openvpn
install_easy_rsa
