#!/usr/bin/awk -f

func filter_board(board,num, i) {
  for (i in boards[board]) {
    if (boards[board][i] == num) {
      boards[board][i] = "X"
    }
  }
}

func is_done(board) {
  row = 0
  col = 0
  delete rows
  delete cols
  while (row < 5 && col < 5) {
    if (!(rows[row] == "no" && cols[col] == "no") && boards[board][row * 5 + col] != "X") {
      rows[row] = "no"
      cols[col] = "no"
    }

    col++
    if (col % 5 == 0) {
      col = 0
      row++
    }
  }

  for(i=0;i<5;i++) {
    if (rows[i] != "no" || cols[i] != "no") {
      return 1
    }
  }
  return 0
}

func find_last_winner() {
  for (i in nums) {
    CURR_NUM = nums[i]
    all_done = 1
    for (board in boards) {
      if (!finished_boards[board]) {
        all_done = 0
        filter_board(board, CURR_NUM)
        if (is_done(board)) {
          finished_boards[board] = "yes"
          last_winner = board
        }
      }
    }
    if (all_done) {
      return last_winner
    }
    PREV_NUM = CURR_NUM
  }
  return -1
}

/,/ {split($0,nums,",")}

/$^/ {
  board += 1
  row = 0
}

/ *([0-9]+ *){5}/ {
  split($0, row_arr, " ")
  for (i in row_arr) {
    boards[board][(row * 5) + i - 1] = row_arr[i]
  }
  row++
}

END {
  WINNER = find_last_winner()
  print WINNER
  print PREV_NUM
  for (i in boards[WINNER]) {
    WINNER_SUM += boards[WINNER][i]
  }

  print WINNER_SUM * PREV_NUM
}