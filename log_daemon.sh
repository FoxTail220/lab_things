#!/bin/bash

log_file="/var/log/nginx/access.log"

output_file="/var/log/nginx/file1.log"

deleted_logs="/var/log/nginx/file2.log"

error_500="/var/log/nginx/error_500.log"

error_400="/var/log/nginx/error_400.log"


# Updating file1.log
last_size=0

while true; do
    current_size=$(wc -c < "$log_file")
      if [ $current_size -gt $last_size ]; then
        tail -c +$((last_size + 1)) "$log_file" >> "$output_file"


tail -c +$((last_size + 1)) "$log_file | while read line; do

# Searching for 5xx and 4xx fails

    errcode=$(echo "$line" | awk '{print $7}')
      if [[ "$errcode" == 4* ]]; then
        echo "$line" >> "$error_400"
      elif [[ "$errcode" == 5* ]]; then
	echo "$line" >> "$error_500"
      fi
done
    last_size=$current_size

      fi

# Cleaning-up file1.log with report writed file2.log
        if [ $(stat -c %s "$output_file") -gt 20000 ]; then
                echo "$(date): Logs cleaned. Deleted $(wc -l < "$output_file") strings." >> "$deleted_logs"
                > /var/log/nginx/file1.log
        fi
    sleep 5
done
