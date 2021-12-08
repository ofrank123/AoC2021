#!/usr/bin/awk -f

func init_map() {
  delete map
  for (i in segs) {
    seg = segs[i];
    map[seg] = "abcdefg";
  }
}

func filter_map(seg,keep, contained) {
  if (keep) gsub("[^" keep "]","", map[seg]);
}

func filter_map_len(seg,len, keep) {
  if (len == 2) keep="cf";
  if (len == 3) keep="acf";
  if (len == 4) keep="bcdf";

  filter_map(seg,keep);
}

func filter_map_lc(seg,lc, keep) {
  if (lc == 4) keep="e";
  if (lc == 6) keep="b";
  if (lc == 7) keep="dg";
  if (lc == 8) keep="ac";
  if (lc == 9) keep="f";

  filter_map(seg,keep);
}

func sort_str(str, arr,ret,i) {
  n=split(str,arr,"");
  asort(arr);
  for(i=1;i<=n;i++) ret = ret arr[i];
  return ret;
}

BEGIN { 
  FS=" \\| ";
  used_in["a"][1] = 0;
  split("abcdefg",segs,"");
}

{
  split($1,inputs," ");
  init_map();
  delete letter_cnts;
  # Filter by input len
  for (i in inputs) {
    input = inputs[i];
    len = length(input);
    split(input, c_segs, "");
    for (j in c_segs) {
      letter_cnts[c_segs[j]]++;
      filter_map_len(c_segs[j],len);
    }
  }

  # Filter by letter count
  for (i in letter_cnts) {
    filter_map_lc(i,letter_cnts[i]);
  }
  
  # Filter set characters out
  for (i in map) {
    if (length(map[i]) == 1) {
      uniqueChars = uniqueChars map[i];
    }
  }

  for (i in map) {
    if (length(map[i]) != 1) gsub("[" uniqueChars "]", "", map[i]);
  }

  split($2, outputs, " ");
  for (i in outputs) {
    new_out = "";
    for (j in map) {
      if (match(outputs[i], j))  {
        new_out = new_out map[j];
      }
    }
    
    outputs[i] = sort_str(new_out);
  }

  num = "";
  for (i in outputs) {
    o = outputs[i];
    next_dig = "";
    if (o == "abcefg") next_dig = 0;
    if (o == "cf") next_dig = 1;
    if (o == "acdeg") next_dig = 2;
    if (o == "acdfg") next_dig = 3;
    if (o == "bcdf") next_dig = 4;
    if (o == "abdfg") next_dig = 5;
    if (o == "abdefg") next_dig = 6;
    if (o == "acf") next_dig = 7;
    if (o == "abcdefg") next_dig = 8;
    if (o == "abcdfg") next_dig = 9;

    num = num next_dig;
  }

  total += num;
}

END { print total }