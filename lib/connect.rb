class ConnectFour
  attr_accessor :board_pieces

  def initialize
    @board_pieces = Array.new(6) { Array.new(7, '_') }
  end

  def get_board
    @board = layout
  end

  def layout
    board = ""
    board_pieces.reverse.each do |row|
      row_string = row.map { |piece| "| #{piece} "}.join
      board += "#{row_string}|\n"
    end
    board
  end

  def make_move(board, column, piece)
    row = 0
    move_made = false
    until row > 5 || move_made
      if board[row][column] == '_'
        board[row][column] = piece.force_encoding('utf-8')
        move_made = true
      end
      row += 1
    end
    return "Can't make this move!" unless move_made
    nil
  end

  def check_winner(board)
    # horizontal check
    board.each_with_index do |row, r_index|
      (0..board[0].length - 4).each do |c_index|
        if (board[r_index][c_index] == board[r_index][c_index + 1]) && (board[r_index][c_index + 1] == board[r_index][c_index + 2]) &&
            (board[r_index][c_index + 2] == board[r_index][c_index + 3]) && board[r_index][c_index] != '_'
          return board[r_index][c_index]
        end
      end
    end
    # vertical check
    board[0].each_with_index do |column, c_index|
      (0..board.length - 4).each do |r_index|
        if (board[r_index][c_index] == board[r_index + 1][c_index]) && (board[r_index + 1][c_index] == board[r_index + 2][c_index]) &&
            (board[r_index + 2][c_index] == board[r_index + 3][c_index]) && board[r_index][c_index] != '_'
          return board[r_index][c_index]
        end
      end
    end
    # upward check
    board.each_with_index do |row, r_index|
      row.each_with_index do |column, c_index|
        if r_index >= 3 && c_index >= 3
          if (board[r_index][c_index] == board[r_index - 1][c_index - 1]) && (board[r_index - 1][c_index - 1] == board[r_index - 2][c_index - 2]) &&
             (board[r_index - 2][c_index - 2] == board[r_index - 3][c_index - 3]) && board[r_index][c_index] != '_'
            return board[r_index][c_index]
          end
        end
      end
    end
    # downward check
    board.each_with_index do |row, r_index|
      row.each_with_index do |column, c_index|
        if r_index <= 2 || c_index <= board[0].length - 4
          if (board[r_index][c_index] == board[r_index - 1][c_index + 1]) &&
             (board[r_index - 1][c_index + 1] == board[r_index - 2][c_index + 2]) &&
             (board[r_index - 2][c_index + 2] == board[r_index - 3][c_index + 3]) &&
             board[r_index][c_index] != '_'
            return board[r_index][c_index]  # Return the winner ('0' or 'x')
          end
        end
      end
    end
    false
  end

  def get_user_input(player)
    valid_input = false
    until valid_input
      print "In which column from 1 to 7 do you want to play at, #{player}? "
      user_input = gets.chomp.to_i
      valid_input = true if user_input >= 1 && user_input <= 7
    end
    user_input
  end

  def game_round(player)
    piece = player == 'Red' ? "\u{1F534}" : "\u{1F7E1}"
    print get_board
    p
    player_move = get_user_input(player) - 1
    make_move(@board_pieces, player_move, piece)
    return check_winner(@board_pieces)
  end

  def play_game
    game_winner = false
    current_player = 'Red'
    until game_winner
      game_winner = game_round(current_player)
      current_player = current_player == 'Red' ? 'Yellow' : 'Red'
    end
    print get_board
    p
    game_winner == "\u{1F534}" ? (puts "Red won!") : (puts "Yellow won!")
  end
end