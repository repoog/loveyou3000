#!/bin/bash

base_path="/home/ubuntu/loveyou3000"
is_start_path=$base_path"/is_start.txt"
days_path=$base_path"/days.txt"
ascii_path=$base_path"/ascii.txt"
commit_path=$base_path"/commit.txt"

today=$[$[$(date +%w)+1]%7]
is_start=$(cat $is_start_path)

if [ $today -eq 1 -a $is_start -eq 0 ]; then
	echo 1 > $is_start_path
elif [ $is_start -eq 0 ]; then
	echo "Wrong date, quit."
	exit
fi

day=$(cat $days_path)
echo $[$day+1] > $days_path

line_num=$[$[$day/7]+1]
ascii_num=$[$[$day%7]+1]

line_ascii=$(sed -n $[$line_num]p $ascii_path)
flag=$(echo $line_ascii | cut -c$ascii_num)

if [ $flag -eq 0 ]; then
	echo "Not commit"
	exit
elif [ $flag -eq 1 ]; then
	echo "Love Love Love"
	for i in {0..7}
	do
		echo $i > $commit_path
		cd $base_path
		git add .
		git commit -m 'love you'
		git push origin master	
	done
fi
