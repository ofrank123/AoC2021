#!/usr/bin/awk -f
func b(i, t,a,c) {
  a=1;
  for(c = length(i); c>0; c--) {
    t += substr(i,c,1)=="1" ? a : 0
    a*=2
  }
  return t
}

{
	split($1,a,"")
	for(i in a) {
		count[i] += a[i]
	}
}

END {
	for(i in count) {
    cnd = count[i] > (NR / 2)
    g[i] = cnd ? 1 : 0
    e[i] = cnd ? 0 : 1
	}
  for (i in g) {
    g_str = g_str g[i]
    e_str = e_str e[i]
  }
  print b(g_str) * b(e_str)
}