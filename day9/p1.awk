#!/usr/bin/awk -f

func is_low(x, y) {
  this_height = map[x "," y];
  n1 = map[x-1 "," y];
  n1 = n1 != "" ? n1 : 100;
  n2 = map[x+1 "," y];
  n2 = n2 != "" ? n2 : 100;
  n3 = map[x "," y-1];
  n3 = n3 != "" ? n3 : 100;
  n4 = map[x "," y+1];
  n4 = n4 != "" ? n4 : 100;
  if (n1 > this_height && n2 > this_height && n3 > this_height && n4 > this_height) {
    SUM += this_height + 1;
  }
}

BEGIN { FS = "" }

{ 
  for (i=1;i<=NF;i++) {
    map[i "," NR] = $i;
  }
}

END {
  for (y=1;y<=NR;y++) {
    for (x=1;x<=NF;x++) {
      is_low(x,y);
    }
  }
  print SUM;
}