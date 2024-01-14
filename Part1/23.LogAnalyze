#!/bin/bash
  echo -e "\nPOD LOG Analyze\n"

  echo -e ":: COUNT OF ACCESS IP ::"
  cat 0.log | grep GET | awk '{print $4}' | sort | uniq -c | sort -n

  echo -e "\n:: COUNT OF ACCESSER BY HOUR ::"
  cat 0.log | grep GET | awk '{print $4}' | awk -F ":" '{print $2}' | uniq -c

  echo -e "\n:: COUNT OF HTTP STATUS CODE ::"
  cat 0.log | grep GET | awk '{print $12}' | sort | uniq -c

  echo -e "\n"
