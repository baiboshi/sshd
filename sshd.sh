#!/bin/bash
ywcx=`cat /proc/sys/kernel/random/uuid| md5sum | cut -c1-8`
echo $ywcx
#dockerfile 
docker build . -t sshd$ywcx 2>&1 | tee /tmp/sshd.log
imagesid=`awk 'END{print $3}' /tmp/sshd.log`
read -p "输入映射端口号" ailab
docker run -tid -p $ailab:22 --name sshd$ywcx sshd$ywcx:latest
#写入进入容器脚本
cat >/usr/local/bin/sshd$ywcx<<EOF
#！/bin/bash
name=sshd$ywcx
CntainerID=\`docker ps -q --no-trunc --filter name=\^\$name$\`
echo \$CntainerID
#Get the dockerID process number
IDnumber=\`docker inspect -f {{.State.Pid}} \$CntainerID\`
echo \$IDnumber
#Enter docker container
nsenter --target \$IDnumber --mount --uts --ipc --net --pid
EOF
chmod +x /usr/local/bin/sshd$ywcx
echo "sshd$ywcx" > list
echo "新建容器为:sshd$ywcx"





