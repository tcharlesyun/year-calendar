#!/bin/bash

year=`date +%Y`

month=0

# echo "$year Su Mo Tu We Th Fr Sa Su Mo Tu We Th Fr Sa Su Mo Tu We Th Fr Sa Su Mo Tu We Th Fr Sa Su Mo Tu We Th Fr Sa Su Mo"

while [[ $month -lt 12 ]]
do	
	month=$(( $month + 1 ))
	mmm=`date -v"$month"m +%b`
	week=1
	
	echo -n " $mmm "
	while [[ $week -lt 7 ]]
	do
		iteration=$(( 7 - $week ))
	
		week_curr=`cal $month 2008 | tail -$iteration | head -1 | sed 's/\n//' `
		a=`echo -n "$week_curr "`
		week_full="$week_full""$a"
		
		week=$(( $week + 1 ))
	done
	# echo 
	echo "$week_full"
	week_full=""

done

