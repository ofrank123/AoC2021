#!/usr/bin/awk -f

BEGIN { FS=" \\| " }

{
  split($2,outputs," ");
  for (o in outputs) {
    len = length(outputs[o]);
    if (len == 2 || len == 3 || len == 4 || len == 7) total++;
  }
}

END { print total }