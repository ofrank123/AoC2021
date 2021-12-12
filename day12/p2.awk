#!/usr/bin/awk -f

func findPaths(path, any_twice, p_arr, pos_arr, current, pos) {
  delete p_arr;
  split(path, p_arr, ",");
  current = p_arr[length(p_arr)];
  if (current == "end") {
    PATHS[path] = 1;
  } else {
    delete pos_arr;
    split(map[current], pos_arr, ",");
    for (i in pos_arr) {
      pos = pos_arr[i];
      if (pos == "end" ||
          toupper(pos) == pos) {
        findPaths(path "," pos, any_twice);
      }
      else if (pos != "start" && tolower(pos) == pos) {
        if(index(path,pos) == 0) {
          findPaths(path "," pos, any_twice);
        } 
        else if (!any_twice) {
          findPaths(path "," pos, 1);
        }
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
  print length(PATHS);
}