#!/bin/bash
#curl  http://10.0.0.202/details.xml --silent | sed '2 s/xmlns=".*"//g' | xmllint --xpath "string(/Devices-Detail-Response/owd_DS18B20[ROMId='E3000003AE0BCD28']/Temperature)" -

# Determine device family
DeviceType=DS18B20
DeviceID=$1
Family=${DeviceID: -2}
#echo $Family 
case $Family in
 1D) DeviceType=DS2423 ;;
 26) DeviceType=DS2438 ;;
 28) DeviceType=DS18B20 ;;
 10) DeviceType=DS18S20 ;;
 *) echo "Family $Family not supported"
 exit 1 ;;
esac
#echo $DeviceType

# Check requested data type

case $2 in
 [tT]emperature) Value=Temperature ;;
 [hH]umidity) Value=Humidity ;;
 [cC]ounters.[aA]) Value=Counter_A ;;
 [cC]ounters.[bB]) Value=Counter_B ;;
 *) echo "$2 is not a valid data type"
  exit 1 ;;
esac
#echo $Value

curl  http://10.0.0.202/details.xml --silent | sed '2 s/xmlns=".*"//g' | xmllint --xpath "string(/Devices-Detail-Response/owd_$DeviceType[ROMId='$1']/$Value)" -
