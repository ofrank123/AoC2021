#!/usr/bin/awk -f
{
	if ($1 > prev_n) {cnt++}
	prev_n = $1
}
END 	{ print cnt-1}
