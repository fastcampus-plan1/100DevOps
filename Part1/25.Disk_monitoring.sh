#!/bin/bash
#
# /var/log와 /home 디스크 공간을 확인하는 스크립트
#
CHECK_DIRECTORIES='/var/log /home' # 확인할 디렉토리
#
############## Main Script #################################
#
DATE=$(date '+%y%m%d')               #리포트 파일에 날짜 출력
#
exec > disk_space_$DATE.txt          #표준출력으로 리포트 파일 생성
#
echo "Top Ten Disk Space Usage"      #리포트 제목
echo "for $CHECK_DIRECTORIES Directories"
#
for DIR_CHECK in $CHECK_DIRECTORIES  # 반복
do
  echo ''
  echo "The $DIR_CHECK Directory:"   #디렉토리 제목
#
# 이 디렉토리 중 상위 10곳 확인 
  du -S $DIR_CHECK 2>/dev/null |
  sort -rn |
  sed '{11,$D; =}' |
  sed 'N; s/\n/ /' |
  gawk '{printf $1 ":" "\t" $2 "\t" $3 "\n"}'
#
done                                # 루프 종료
#
exit
