DNS_IP=""

#nslookup -port=8080 $domain 106.52.100.60
PORT=38888
IP=123.1.1.2
domain=$1
# echo $domain
res=/tmp/smartdnsres/${domain}.txt
COUNTER=0
while [ -z $DNS_IP ] && [ $COUNTER -lt 4 ]; do
  DNS_IP=$(nslookup -port=${PORT} ${domain} ${IP} | awk '/^Address: / { print $2 }')
  [ -z "$DNS_IP" ] && sleep 1
  ((COUNTER++))
done
scp root@${IP}:${res} ${res}
echo `cat ${res}`

# [ -z "$DNS_IP" ] && echo `cat /tmp/aa/${domain}.txt`
# content=`cat /tmp/aa/${domain}.txt`
# echo $content

