#!/usr/bin/awk -f

BEGIN { FS = "," }

/.+,.+/ { 
  map[$1","$2] = 1
  MAX_X = $1 > MAX_X ? $1 : MAX_X;
  MAX_Y = $2 > MAX_Y ? $2 : MAX_Y;
}

/^$/ { FS = "=" }

/fold along/ {
  if (!FOLDED) {
    if ($1 == "fold along y") {
      for (i in map) {
        split(i,a,","); x=a[1]; y=a[2];
        if (y > $2) {
          map[i] = "";
          map[x","((2*$2)-y)] = 1;
        }
      }
      MAX_Y = $2;
    } else {
      for (i in map) {
        split(i,a,","); x=a[1]; y=a[2];
        if (x > $2) {
          map[i] = "";
          map[((2*$2)-x)","y] = 1;
        }
      }
      MAX_X = $2;
    }
    FOLDED = 1;
  }
}

END {
  for(y=0;y<=MAX_Y;y++) {
    for(x=0;x<=MAX_X;x++) {
      if (map[x","y]) TOTAL++;
    }
  }
  print TOTAL;
}