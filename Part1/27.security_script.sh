#!/bin/bash

. 27.function.sh

BAR
CODE [U-01] root 계정 원격 접속 제한
cat << EOF >> $RESULT
[양호]: 원격 서비스를 사용하지 않거나 사용 시 직접 접속을 차단한 경우.
[취약]: root 직접 접속을 허용하고 원격 서비스를 사용하는 경우.
EOF
BAR

SERVICE1=telnet.socket
systemctl is-active $SERVICE1 >/dev/null 2>&1

if [ $? = 0 ]; then
    INFO "텔넷 서비스가 활성화 되어있습니다."
    VALUE1=$(cat /etc/securetty | grep "^pts" | wc -l)
    if [ $VALUE1 != 0 ] ; then
        WARN "root 직접 접속을 허용하고 원격 서비스를 사용하는 경우."
    else 
        OK "원격 서비스를 사용하지 않거나 사용 시 직접 접속을 차단한 경우."
    fi    
else
    OK "텔넷 서비스가 비활성화 되어있습니다."
fi

SERVICE2=sshd.service
systemctl is-active $SERVICE2 >/dev/null 2>&1
if [ $? = 0 ]; then
    INFO "SSH 서비스가 활성화 되어있습니다."
    VALUE2=$(cat /etc/ssh/sshd_config | grep 'PermitRootLogin yes' | awk {'print $2'})
    if [ $VALUE2 == "yes" ] ; then
        WARN "root 직접 접속을 허용하고 원격 서비스를 사용하는 경우."
    else 
        OK "원격 서비스를 사용하지 않거나 사용 시 직접 접속을 차단한 경우."
    fi    
else
    OK "SSH 서비스가 비활성화 되어있습니다."
fi

cat $RESULT
