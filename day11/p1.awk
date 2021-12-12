#!/usr/bin/awk -f

func print_map(i, x,y) {
  printf "\033[0,0H";
  printf "%02d:\n", i;
  for(y=1;y<=NR;y++) {
    for(x=1;x<=NF;x++) {
      if (map[x,y] == 0) {
        printf "\033[37;1m%s\033[0m", map[x,y];
      } else {
        printf "%s", map[x,y];
      }
    }
    print "";
  }
  printf "Flashes: %d\n", FLASHES;
  system("sleep .1");
}

func inc_energy(x,y) {
  if (map[x,y] != "" && map[x,y] != "X") {
    map[x,y]++;
    if (map[x,y] > 9) {
      map[x,y] = "X";
      inc_energy(x-1, y-1);
      inc_energy(x, y-1);
      inc_energy(x+1, y-1);
      inc_energy(x-1, y);
      inc_energy(x+1, y);
      inc_energy(x-1, y+1);
      inc_energy(x, y+1);
      inc_energy(x+1, y+1);
      FLASHES += 1;
    }
  }
}

func run_step(x,y) {
  for(y=1;y<=NR;y++) {
    for(x=1;x<=NF;x++) {
      inc_energy(x,y);
    }
  }
  for(y=1;y<=NR;y++) {
    for(x=1;x<=NF;x++) {
      if (map[x,y] == "X") {
        map[x,y] = 0;
      }
    }
  }
}

BEGIN { FS = "" }

{
  for(i=1;i<=NF;i++) {
    map[i,NR]=$i;
  }
}

END { 
  printf "\033c";
  for(i=0;i<100;i++) {
    print_map(i);
    run_step();
  }
  print_map(i);
}