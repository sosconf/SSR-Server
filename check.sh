#!/bin/bash

if [ ! -f "./output.logs" ];then
touch output.logs
fi

# check the server port
serverIP="8.8.8.8"
port=1234
IPstatus=$(nc -z -w 1 $serverIP $port && echo ok || echo no)
if [ "$IPstatus" == "ok" ];then
    echo `date`:"server port is normal" | tee -a output.logs
else
    echo `date`:"server port is abnormal" | tee -a output.logs
fi

# check third-party resources
resource1="raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ssrmu.sh"
urlstatus=$(curl -s -m 4 -IL $resource1|grep 200)
if [ "$urlstatus" == "" ];then
    echo `date`:"$resource1 is OFF" | tee -a output.logs
else
    echo `date`:"$resource1 is OK" | tee -a output.logs
fi

resource2="github.com/teddysun/across/raw/master/bbr.sh"
urlstatus=$(curl -s -m 2 -IL $resource2|grep 200)
if [ "$urlstatus" == "" ];then
    echo `date`:"$resource2 is OFF" | tee -a output.logs
else
    echo `date`:"$resource2 is OK" | tee -a output.logs
fi
