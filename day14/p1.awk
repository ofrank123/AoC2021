#!/usr/bin/awk -f

func run_step( i,curr,prev,new_poly) {
  split(POLY,a,"");
  for(i in a) {
    curr = a[i];
    ins = rules[prev curr];
    if (ins) {
      new_poly = new_poly prev ins;
    }
    prev = curr;
  }
  new_poly = new_poly prev;
  POLY = new_poly;
}

{
  if (NR == 1) {
    POLY = $0;
    FS = " -> ";
  }
  else if (NR > 2) {
    rules[$1] = $2;
  }
}

END {
  for (i=0;i<10;i++) { print i; run_step(); }
  split(POLY,a,"");
  for(i in a) count[a[i]]++;
  for(i in count) {
    n = count[i];
    if (MIN == "") MIN = n;
    MIN = n < MIN ? n : MIN;
    MAX = n > MAX ? n : MAX;
  }
  print MAX - MIN;
}