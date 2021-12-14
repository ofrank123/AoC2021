#!/usr/bin/awk -f

func copy(lhs,rhs) {
  delete rhs;
  for(i in lhs) {
    rhs[i] = lhs[i];
  }
}

func run_step( i,n_polys,a) {
  delete n_polys;
  for(i in POLYS) {
    ins = rules[i];
    split(i,a,"");
    n_polys[a[1] ins] += POLYS[i];
    n_polys[ins a[2]] += POLYS[i];
  }
  copy(n_polys, POLYS);
}

{
  if (NR == 1) {
    split($0,a,"");
    for(i in a) {
      c = a[i];
      if (prev != "") {
        POLYS[prev c]++;
      }
      prev = c;
    }
    END_C = c;
    FS = " -> ";
  }
  else if (NR > 2) {
    rules[$1] = $2;
  }
}

END {
  for(j=0;j<40;j++) {
    run_step();
  }
  for (i in POLYS) {
    split(i,a,"");
    count[a[1]] += POLYS[i];
  }
  count[END_C]++;
  for(i in count) {
    n = count[i];
    if (MIN == "") MIN = n;
    MIN = n < MIN ? n : MIN;
    MAX = n > MAX ? n : MAX;
  }
  print MAX - MIN;
}