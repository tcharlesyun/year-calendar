#!/bin/bash
# -----------------------------------------------------------------------------
# year-cal
#
# a silly program to print the output of `cal` in a different row/col 
# formats than the default 3 monthw wide by 4 months tall
# 
# 
# -----------------------------------------------------------------------------
# Author/Info
# T. Charles Yun
# tcharlesyun // hotmail // com
#   with the above info, you should be able to use Google to get access to 
#   email addresses that I use more frequently
# License
#   released GPL version 2 for those silly enough to want this
#   that said, I do not have a copy of the license handy...
# 
# -----------------------------------------------------------------------------
# todo:
# - highlight curr month name? 
# - i have had more than one day in which the output highlighting broke.  just 
#   tried to check the code today (hard coding the dates on which errors 
#   occured) and things work fine.  not sure what was wrong prev.  odd...
#  
# -----------------------------------------------------------------------------
# Updates
#
# 2009 Mar 25
# - added conditional so that date is only highlighted for current year
# 
# 2008 Oct 05
# - fixed prob with Sunday highlighting
# - fixed prob with first column highlighting
# - variable checks are now working (i hope)
#
# 2008 Jun
# - created first pass
#
# -----------------------------------------------------------------------------
# defaults and pre-calcs

year=`date +%Y `
today_year=`date +%Y `
today_month=`date +%m | sed -E 's/^0//'  `
today_date=`date +%d | sed -E 's/^0/ /'  | sed -E 's/$/ /'  ` 

num_cols=4
num_rows=3		

row_month=1

#ornament_l="\033[1m*"
#ornament_r="*\033[0m"

ornament_l="\033[1;36m*"
ornament_r="*\033[0m"

#ornament_l="*"
#ornament_r="*"
	# note: ornament left/right 
	# but the idea is that it could be used to force the term to 
	# change colors.  if this is done, i assume one would need a full
	# section to determine the operating system and then the term type,
	# avail colors, etc.
	# 
	#  "\[\033[1;36m\]"
	#  "\[\033[0m\]"


# -----------------------------------------------------------------------------
check_variables() {

	# check year 
	# - is it set
	# - is it an integer
	# check col/width
	# - are they set
	# - do they multiply to 12
	
	if [[ $1 ]]
	then
		if [[ `echo "$1" | grep -E ^[[:digit:]]\{1,\}$` ]]
		then
			year=$1

			if [[ $2 ]]
			then
				if [[ ! `echo "$2" | grep -E ^[[:digit:]]\{1,\}$` ]] 
				then
					# sigh, i was getting tired of embedded if/thens
					# so this just checks if $2 is a digit
					# if $3 is not a digit, i think that the
					# multiplication check below will flag it.
					
					mcUsage
				fi
				
				if [[ ! $3 ]]
				then
					mcUsage
				fi
				
				if [[ $(( $2 * $3 )) -ne 12 ]] 
				then
					mcUsage
				else
					num_cols=$2
					num_rows=$3		
					makeCalendar
				fi
			else
				# use all defaults as set above
				makeCalendar
			fi



			makeCalendar
	
		else
			mcUsage
		fi
	else
		# use all defaults as set above
		makeCalendar
	fi

}

# -----------------------------------------------------------------------------
# usage

mcUsage() {
	echo "yc  (year calendar)"
	echo "" 
	echo "Description: "
	echo "    a script that modifies the output of calto print a year's calendar"
	echo "    with arbitrary numbers of columns and rows."
	echo "Usage:"
	echo "    year-cal [year [ [[number of cols] [numer of rows]]]]"
	echo ""
	echo "    If no year is provided, the current year is calculated via the date"
	echo "    command.  If a year is provided, the number of columns and rows can"
	echo "    be provided, both are required and the product (row x col) must"
	echo "    equal 12."
	echo "Example:"
	echo "    yc 2008 4 3"
	echo "    would return the 2008 calendar, with four months in columns"
	echo "    and three months of rows.  Briefly as below:"
	echo "    "
	echo "              2008"
	echo "        jan feb mar apr"
	echo "        may jun jul aug"
	echo "        sep oct nov dec"
	echo "    "
	
	exit

}

# -----------------------------------------------------------------------------
makeCalendar() {		
	while [[ $row_month -le 12 ]]
		do
			for row_week in 1 2 3 4 5 6 7 8
			do
				col_month=0
				while [[ $col_month -lt $num_cols  ]]
				do				
					curr_month=$(( $row_month + $col_month ))
					
					month_line=`cal $curr_month $year | head -$row_week | tail -1`
					
					# must prepend a space so that the first column dates can get an asterisk
					month_line=" $month_line"
					
					while [ ${#month_line} -le 21 ]
					do
						month_line="$month_line "
					done
					
					
					
					if [[ $curr_month == $today_month ]] && [[ `echo $month_line | grep $today_date ` ]]
					then
						# ok, this is really sloppy, but i am sed'ing for "spaceDATEspace" and
						# if the date is on sunday, then there is no leading space.
						# so i am creating an exception IF/THEN statement to 
						# deal with it.  I suspect that there are better/correct/elegant
						# ways to do this...
						
						# echo ""
						# echo "cm:x$curr_month x$today_month x"
                                                # 
						# echo "ml:x$month_line x"
						# echo "td:x$today_date x"
                                                # 
							
						if [[ `echo $month_line | grep "$today_date"` ]] && [[ $year == $today_year ]]
						then
							today_date=`echo "$today_date" | sed -E 's/^ //' | sed -E 's/ $//' `
							month_line=$(echo "$month_line" | sed "s/ $today_date /`echo -e $ornament_l$today_date$ornament_r`/" )
							#month_line=$(echo "$month_line" | sed "s/$today_date /`echo -e "$ornament_l""$today_date""$ornament_r"`/" )
						else
							month_line=$(echo "$month_line" | sed "s/ $today_date /`echo -e $ornament_l$today_date$ornament_r`/" )
						fi
					fi
					
					
					full_line=$full_line$month_line 
					
					col_month=$(( $col_month + 1 ))
				done
				
				echo -e "$full_line"
				# i do not think this is needed, but it might be a good 
				# to have just in case.  it re-sets the screen back 
				# to a default state
				# tput sgr0
				
				full_line=""
				
			done
		row_month=$(( $row_month + $num_cols ))
		
	done

}

# -----------------------------------------------------------------------------
# start by running the check variables procedure
# that procedure will then call the calendar procedure



check_variables $1 $2 $3

