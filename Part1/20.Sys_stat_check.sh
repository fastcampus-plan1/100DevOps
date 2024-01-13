#!/bin/bash
yum install -y sysstat
echo "Hostname: $(hostname)"
echo "Current date: $(date)"
echo "Current kernel version and CPU architecture: $(uname -rp)"
# Sar의 기본 첫번째 줄 출력은 커널을 의미하므로 제외. -u은 cpu 사용률
echo "Current CPU usage:"
sar -u 1 1| grep -v "Linux"
echo ""
echo "Current memory usage:"
sar -r 1 1| grep -v "Linux"
echo ""
echo "Current swap space usage:"
sar -S 1 1| grep -v "Linux"
echo ""
# Sar를 통해서 디스크 정보를 볼 수 있는데 너무 많기에 의미 있는 sd*/vd*/DEV로만 확인
echo "Current disk I/O:"
sar -d 1 1| grep -E "(DEV|dev|sd|vd)" | grep -v "Linux"
echo ""
# Sar 에서 나오는 장치 중 루프백은 굳이 볼 필요 없으므로 제외
echo "Current network bandwidth usage:"
sar -n DEV 1 1| grep -v lo | grep -v "Linux"
