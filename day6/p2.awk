#!/usr/bin/awk -f

BEGIN { FS = "," }
{
  for (i=1;i<=NF;i++) fish[$i]++
}
END {
  for(gen=0;gen<256;gen++) {
    fish0 = fish[0]
    for(i=0;i<8;i++) {
      fish[i] = fish[i+1]
    } 
    fish[6] += fish0
    fish[8] = fish0
  }

  for (i in fish) {
    sum += fish[i]
  }

  print "GEN:\t" gen "\tSUM:\t" sum
}