#!/usr/bin/awk -f

func calc_fuel(target, total_cost, cost, crab) {
  for (crab in crabs) {
    cost = (crab+0) > (target+0) ? (crab - target) : (target - crab);
    total_cost += ((cost*(1+cost))/2) * crabs[crab];
  }
  return total_cost;
}

BEGIN { FS = "," }

{
  min_crab = $1;
  max_crab = $1;
  for (i=1;i<=NF;i++) {
    min_crab = $i < min_crab ? $i : min_crab;
    max_crab = $i > max_crab ? $i : max_crab;
    crabs[$i]++;
  }
}

END {
  cheapest = calc_fuel(min_crab);
  for(i=min_crab+1;i<=max_crab;i++) {
    fuel = calc_fuel(i);
    cheapest = fuel < cheapest ? fuel : cheapest;
  }
  print cheapest
}