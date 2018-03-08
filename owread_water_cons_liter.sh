#!/bin/bash
read prev < /opt/bash-scripts/owread_watervalue.txt
#current=$(owread 1D.FB970F000000/counters.B)
current=$(/opt/bash-scripts/owfs_GenericRead.sh 350000000F97FB1D counters.b)

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



