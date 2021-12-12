#!/usr/bin/awk -f

func print_map(i, x,y) {
  printf "\033[0,0H";
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
  printf "Part 1: %d\n", FLASHES;
  printf "Part 2: %d\n", i;
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
      if (STEP < 100) {
        FLASHES += 1;
      }
    }
  }
}

func run_step(x,y) {
  for(y=1;y<=NR;y++) {
    for(x=1;x<=NF;x++) {
      inc_energy(x,y);
    }
  }
  allFlashed = 1;
  for(y=1;y<=NR;y++) {
    for(x=1;x<=NF;x++) {
      if (map[x,y] == "X") {
        map[x,y] = 0;
      } else {
        allFlashed = 0;
      }
    }
  }
  return allFlashed;
}

BEGIN { FS = "" }

{
  for(i=1;i<=NF;i++) {
    map[i,NR]=$i;
  }
}

END { 
  printf "\033c";
  done = 0;
  for(STEP=0;!done;STEP++) {
    print_map(STEP);
    done = run_step();
  }
  print_map(STEP);
}