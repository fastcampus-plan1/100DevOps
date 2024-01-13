# 사전 환경세팅
mkdir ~/backup
touch ~/backup/abc
touch ~/backup/cdf
echo abc > ~/backup/files_to_backup.txt
echo cdf >> ~/backup/files_to_backup.txt
ll ~/backup
cat ~/backup/files_to_backup.txt
cd ~/backup

###### 아래가 쉘 스크립트입니다 #######

#!/bin/bash
# 오늘의 날짜 확인
today=$(date +%y%m%d)
#
# 백업 파일 이름 설정
backupfile=backup_$today.tar.gz
#
# 설정 파일 위치 및 저장될곳 설정
config_file=~/backup/files_to_backup.txt
backup_directory=~/backup/$backupfile
#
# 스크립트 메인
#######################################
#
# 백업 관련한 컨피그 파일이 있는지 확인
#
if [ -f $config_file ] # 컨피그 파일이 있는지
then           # 존재한다면 그냥 패스
     echo
else           # 존재 하지 않다면, 에러 발생시키고 스크립트 종료
     echo
     echo "$config_file isn't exist."
     echo "backup is not started"
     echo
     exit
fi
#
# 백업해야 할 파일 리스트업
#
file_no=1              # 파일 번호는 1번부터 시작
exec 0< $config_file   # 컨피그 파일로 Standard Input으로 redirect
#
read file_name         # Input(컨피그 파일)의 첫줄 file_name으로 읽기
#
while [ $? -eq 0 ]     # 백업할 파일 리스트업
do
     if [ -f $file_name -o -d $file_name ]        # 파일이나 디렉토리가 있는지 확인
     then
          # 만약 파일이 있다면, 이름을 리스트에 추가
          file_list="$file_list $file_name"
     else
          # 만약 파일이 없다면, 경고 메세지 출력하고 진행
          echo
          echo "$file_name, isn't exist."
          echo "Continuing to build backup list"
          echo
     fi
#
     file_no=$[$file_no + 1]  # number 하나씩 증가
     read file_name           # 다음 한줄 읽기
done
#
#######################################
#
# 백업 파일 압축
#
echo "Starting backup"
echo
#
tar -czf $backup_directory $file_list
#
echo "Backup completed"
echo "Resulting backup file is: $backup_directory"
echo
#
exit
