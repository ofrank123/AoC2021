#!/usr/bin/awk -f
{
	sum=prev1+prev2+$1
	if (prev1 && sum > prevSum) {cnt++}
	prev1=prev2
	prev2=$1
	prevSum=sum
}
END 	{ print cnt-1 }
