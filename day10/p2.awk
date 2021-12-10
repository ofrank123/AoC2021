#!/usr/bin/awk -f

BEGIN { 
  FS = "";
  map["("] = ")";
  map["["] = "]";
  map["{"] = "}";
  map["<"] = ">";
  s_map["("] = 1;
  s_map["["] = 2;
  s_map["{"] = 3;
  s_map["<"] = 4;
}

{
  head=0; s=0;
  for(i=1;i<=NF;i++) {
    if (map[$i]) stack[head++] = $i;
    else {
      if(map[stack[--head]] != $i) next;
    }
  }
  while(head > 0) s = s * 5 + s_map[stack[--head]];
  scores[NR]=s
}

END { 
  asort(scores);
  print scores[((length(scores)+1)/2)]
}