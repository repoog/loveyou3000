#!/bin/bash

today=$[$[$(date +%w)+1]%7]
is_start=$(cat is_start.txt)

if [ $today -eq 1 -a $is_start -eq 0 ]; then
	echo 1 > is_start.txt
elif [ $is_start -eq 0 ]; then
	echo "Wrong date, quit."
	exit
fi

day=$[$(cat days.txt)+1]
echo $[$day+1] > days.txt

line_num=$[$[$day/7]+1]
ascii_num=$[$day%7]

line_ascii=$(sed -n $[$line_num]p ascii.txt)
flag=${line_ascii:$[$ascii_num-1]:1}

if [ $flag -eq 0 ]; then
	echo "Not commit"
	exit
elif [ $flag -eq 1 ]; then
	echo "Love Love Love"
	for i in {0..7}
	do
		git commit -m 'love you'
		git push origin master	
	done
fi
