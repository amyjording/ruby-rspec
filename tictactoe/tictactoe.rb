class TicTacToe
  attr_accessor :board
  WIN_COMBINATIONS = [
    [0,1,2],
    [0,3,6],
    [0,4,8],
    [1,4,7],
    [2,4,6],
    [2,5,8],
    [3,4,5],
    [6,7,8]
  ]

  def initialize()
    @board = Array.new(9)
  end

  def play
    while !over?
      turn
    end
    if won?
      puts "#{winner} is the winner!"
    elsif draw?
      puts "It's a draw."
    end
  end

  def display_board
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def turn
    display_board
    puts "Please enter a position 1-9:"
    user_input = gets.strip
    if !valid_move?(user_input)
    puts "Sorry, that's not a valid input."
      turn
    end
    move(user_input, current_player)
    display_board
  end

  def move(location, token)
    @board[location.to_i-1] = token
  end

  def valid_move?(user_input)
    user_input.to_i.between?(1,9) && !position_taken?(user_input.to_i-1)
  end

  def position(location)
    @board[location.to_i]
  end

  def position_taken?(location)
    !(position(location).nil? || position(location) == " ")
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def current_player
      turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      position(combo[0]) == position(combo[1]) &&
      position(combo[1]) == position(combo[2]) &&
      position_taken?(combo[0])
    end
  end

  def draw?
    !won? && @board.all?{|token| token == "X" || token == "O"}
  end

  def over?
    won? || draw?
  end

  def winner
    if winning_combo = won?
      @winner = position(winning_combo.first)
    end
  end

end

# TicTacToe.new.play
