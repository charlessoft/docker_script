res=`sudo firewall-cmd --permanent --list-port`
echo "已开放防火墙端口:"
for item in $res:
do
echo $item
done
