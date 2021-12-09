#!/usr/bin/awk -f

func calc_basin(x,y) {
  if (map[x,y] == 9 || map[x,y] == "") {
    return 0;
  } else {
    map[x,y] = 9;
    return calc_basin(x-1,y) + calc_basin(x+1,y) + calc_basin(x,y-1) + calc_basin(x,y+1) + 1;
  }
}

func print_map(x,y) {
  for (y=1;y<=NR;y++) {
    for (x=1;x<=NF;x++) {
      printf "%s", map[x,y];
    }
    printf "\n";
  }
  printf "---\n";
}

BEGIN { FS = "" }

{ 
  for (i=1;i<=NF;i++) {
    map[i,NR] = $i;
  }
}

END {
  TOTAL = 1;
  basin_i = 1;
  for (y=1;y<=NR;y++) {
    for (x=1;x<=NF;x++) {
      basin = calc_basin(x,y);
      if (basin > 0) {
        basins[basin_i++] = basin;
      }
    }
  }
  asort(basins);
  l_b = length(basins);
  for(i=l_b-2;i<=l_b;i++) {
    TOTAL *= basins[i];
  }
  print TOTAL;
}