#!/bin/bash
read prev < /opt/bash-scripts/owread_watervalue.txt
current=$(owread 1D.FB970F000000/counters.B)

if [ "$current" -eq "$current" ] 2>/dev/null;
then
	echo $current > /opt/bash-scripts/owread_watervalue.txt
fi


if [ $current \> $prev ]; 
then
	echo "scale=2;($current - $prev) /53" | bc
else
	echo 0
fi



