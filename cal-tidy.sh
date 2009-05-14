#!/bin/bash
# -----------------------------------------------------------------------------
# year-tidy
#
# a silly program to print the output of `cal` in a "tight" format
# so that weeks from different months overlap and month names are 
# shown for weeks that have partial days.
# 
# e.g., if the end of the month has 2 days, sunday 29th and mon 30th, 
#       you would see the next month's day listed immediately following
#       instead of as a separate line:
#           mmm  29 30  1  2  3  4  5
#                 7  8  9 10 12 13 14
#       with mmm being the month name for the upcoming month
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
# - add abil to send year from command line
# - variable checks
#   - this might be something i can steal from the other programs...
# - add colorization script so that curr date is highlighted
# - add optional week number in final column?
#
# -----------------------------------------------------------------------------
# Updates
#
# 2008 Oct 07
# - first functioning version
# 
# 2008 Oct 05
# - created first pass
#
# -----------------------------------------------------------------------------
# defaults and pre-calcs

year=2009
month=1

# -----------------------------------------------------------------------------
# write_title
# - 

write_title() {
	echo ""
	echo -n "$year  "
	echo "Su Mo Tu We Th Fr Sa"
}




# -----------------------------------------------------------------------------
# write calendar

write_calendar() {
	while [[ $month -lt 13 ]]
	do
		week=1
		mmm=` date -v"$month"m +%b `
		
		while [[ $week -lt 7 ]]
		do
			iteration=$(( 7 - $week ))
			line_curr=`cal $month $year | tail -$iteration | head -1`
			
			if [[ ${#line_curr} -eq 0 ]]
			then
				blank="true"
				#echo "$iteration:  blank"
				
			elif [[ ${#line_curr} -lt 20 ]]
			then
				blank="false"
				line_prev="$line_curr"
				# echo "x"
	
			else
				blank="false"
				
				if [[ $month -eq 1 ]] && [[ $iteration -eq 6 ]] 
				then
					echo -n " $mmm  "
					echo "$line_curr"
				elif [[ $iteration -eq 6 ]]
				then
					echo -n " $mmm  "
					echo -n "$line_prev"
	
					if [[ ${#line_prev} -eq 0 ]]
					then
						echo -n "$line_curr" | sed -E 's/^ */ /' 
					else
						echo "$line_curr" | sed -E 's/^ */  /' 
					fi
					
					line_prev=""
				else
					echo "      $line_curr"
				fi
				
			fi
			
			
			week=$(( $week + 1 ))
	
		done
	
		month=$(( $month + 1 ))
	done
	
	echo "      $line_prev"
}

# -----------------------------------------------------------------------------
# call procedures

# check_params
write_title
write_calendar
