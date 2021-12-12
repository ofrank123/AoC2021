#!/usr/bin/awk -f

func findPaths(path, p_arr, pos_arr, current, pos) {
  delete p_arr;
  split(path, p_arr, ",");
  current = p_arr[length(p_arr)];
  if (current == "end") {
    TOTAL++;
  } else {
    delete pos_arr;
    split(map[current], pos_arr, ",");
    for (i in pos_arr) {
      pos = pos_arr[i];
      if (toupper(pos) == pos ||
          pos == "end" ||
          match(path,pos) == 0) {
        findPaths(path "," pos);
      }
    }
  }
}

BEGIN { FS = "-" }

{
  map[$1] = !map[$1] ? $2 : map[$1] "," $2;
  map[$2] = !map[$2] ? $1 : map[$2] "," $1;
}

END {
  findPaths("start");
  print TOTAL;
}