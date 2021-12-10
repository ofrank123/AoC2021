#!/usr/bin/awk -f
func b(i, t,a,c) {
  a=1;
  for(c = length(i); c>0; c--) {
    t += substr(i,c,1)=="1" ? a : 0
    a*=2
  }
  return t
}

func insert(val,p_node,level, node,split_v,c,new_n) {
  split(val,split_v,"")
  c = split_v[level]
  node = p_node c
  if(nodes[node]) {
    if (length(nodes[node]) != length(val)) {
      nodes[node]++
      insert(val, node, level + 1)
    } else {
      val2 = nodes[node]
      nodes[node] = 2
      insert(val2,node, level + 1)
      insert(val,node, level + 1)
    }
  } else {
    nodes[node] = val
  }
}

func get_qty(val) {
  if (length(val) == NUM_LEN) return 1
  else return val
}

func get_rating(gte, path) {
  # Get Oxygen Rating
  path = ""
  while (get_qty(nodes[path]) != 1) {
    lv = get_qty(nodes[path 1])
    rv = get_qty(nodes[path 0])
    if (gte ? lv >= rv : lv < rv) path = path 1
    else path = path 0
  }
  return b(nodes[path])
}

{
  insert($1,"",1)
  NUM_LEN = length($1)
}

END {
  oxy_rating = get_rating(1)
  co2_rating = get_rating(0) 

  print "Life Support Rating:", oxy_rating * co2_rating 
}
