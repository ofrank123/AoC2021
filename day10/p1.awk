#!/usr/bin/awk -f

BEGIN { 
  FS = "";
  map["("] = ")";
  map["["] = "]";
  map["{"] = "}";
  map["<"] = ">";
  s_map[")"] = 3;
  s_map["]"] = 57;
  s_map["}"] = 1197;
  s_map[">"] = 25137;
}

{
  head = 0;
  for(i=1;i<=NF;i++) {
    if (map[$i]) stack[head++] = $i;
    else {
      if(map[stack[--head]] != $i) {
        TOTAL += s_map[$i];
        next;
      }
    }
  }
}

END { print TOTAL }