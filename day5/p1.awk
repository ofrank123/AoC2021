#!/usr/bin/awk -f

BEGIN { FS = ",| -> " }

{ 
  if ($1 == $3) {
    start = $4>$2 ? $2 : $4
    end =   $4>$2 ? $4 : $2
    for (i=start;i<=end;i++) {
      field[$1 "," i]++
    }
  }
  if ($2 == $4) {
    start = $3>$1 ? $1 : $3
    end =   $3>$1 ? $3 : $1
    for (i=start;i<=end;i++) {
      field[i "," $2]++
    }
  }
}

END {
  for (i in field) {
    if (field[i] > 1) {
      SLN++
    }
  }
  print SLN
}