#!/bin/bash

sum=0
sums=0

exec 3< <(hexdump -v -e '/1 "%d\n"' "$1")

while read byte
do
  sum=$((($sum+$byte)&65535))
  sums=$((($sums+$sum)&255))
done <&3

msb=$(($sum/256))
lsb=$(($sum&255))

if [ $sum -ge $((0xff01)) ]
then
  chk1=1
  pad1=255
  pad2=$(((0-$lsb)&255))

elif [ $sum -ge $((0xfe02)) ]
then
  chk1=0
  pad1=255
  pad2=$(((1-$lsb)&255))

elif [ $sum -ge $((0xfe00)) ]
then
  chk1=255
  pad1=0
  pad2=$(((1-$lsb)&255))

else
  chk1=$(($msb+2))
  pad1=$((255-$msb))
  pad2=$((255-$lsb))
fi

tmp=$sum

for byte in $pad1 $pad2 $chk1
do
  tmp=$((($tmp+$byte)&255))
  sums=$((($sums+$tmp)&255))
done

chk2=$(((0-$sums-$tmp)&255))

printf `printf "\\%o\\%o\\%o\\%o" $pad1 $pad2 $chk1 $chk2`

