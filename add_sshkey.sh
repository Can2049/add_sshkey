#!/bin/bash
scriptpath=$(cd $(dirname $0); pwd) # get script path
file=$1
user=****
password=****

add_sshkey()
{
    local ip=$1
    local result=0
    #most important!
    sshpass -p ${password} ssh-copy-id -o "StrictHostKeyChecking=no" ${user}@${ip} >/dev/null 2>&1
    result=$?
    if [ ${result} -ne 0 ];then
       printf "${ip} \tadd ssh-key ERROR:$result\n"
    else
       printf "${ip} \tadd ssh-key SUCCESS\n"
    fi
}

while IFS= read -r ip 
do
    if [ "$ip" ] && [ "${ip:0:1}" != "#" ] ; then 
      #echo $ip 
      add_sshkey $ip  & 
    fi
done < "$file"
wait
