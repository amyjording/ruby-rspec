class Player
  attr_accessor :name

@@players = []

  def initialize(name = "#{gets.chomp}")
    @name = name
    @player2 = name
    @@players << @name << @player2
  end

  def self.players
    @@players
  end

end

# mine = Player.new("Joe")
# print Player.players.size

class UprightBoard
  attr_reader :columns

  def initialize
    @columns = []
    7.times { @columns << Array.new }
  end

  def column_empty?(column)
    return false if !column.between?(0,6)
    #test passed without these added commands
    return true if columns[column].size < 6
    return false if columns[column].size >= 6
  end

  def add_to_column(column, player)
    if column_empty?(column)
      columns[column] << player
    else
      return false
    end
  end

  def show_field
    print "\n"
    5.downto(0).each do |i|
      (0..6).each do |j|
        if columns[j][i].nil?
          print "[   ]"
        else
          z = columns[j][i]
          z == 0 ? print("[ " + "☻" + " ]") : print("[ " + "♥" + " ]")
        end
      end
      puts
    end
    print "===================================\n"
  end

  def winner?(newrow)
    x = newrow
    size = columns[x].size
    y = size - 1
    results = []

    return true if (check_col(x, y) if size > 3) || check_row(x, y) || check_diag(x, y)
    return false

  end

  def check_col(col, row)
    ary = []
    columns[col].each_with_index { |field, i| ary << field if (i >= row-3) }
    ary.uniq.size == 1 ? true : false
  end

  def check_row(col, row)
    ary, ary2 = [], []
    first_col = (col - 3 < 0 ? 0 : col - 3)
    last_col = (col + 3 > 6 ? 6 : col + 3)

    (first_col..last_col).each { |x| ary << columns[x][row] }
    ary.each_cons(4) { |group| ary2 << group }

    win = false
    ary2.each do |group|
      if group.uniq.size == 1
        win = true
        break
      end
    end
    return win
  end

  def check_diag(col, row)
    ary, ary2 = [], []
    win = false

    if (col + row > 2) && (col + row < 9)
      (-3..3).each do |i|
        (ary << columns[col + i][row - i]) if (row - i).between?(0, 5) && (col + i).between?(0, 6)
    end
    ary.each_cons(4) do |group|
      if group.uniq.size == 1
        win = true
        break
      end
    end
  end
  if (row - col < 3) && (col - row < 4) && !win
    (-3..3).each do |i|
      (ary2 << columns[col + i][row + i]) if (row + i).between?(0, 5) && (col + i).between?(0, 6)
    end
    ary2.each_cons(4) do |group|
      if group.uniq.size == 1
        win = true
        break
      end
    end
  end
  return win
end

  def is_full?
    return true if columns[0..6].all? { |x| x[5] }
    return false
  end
end

class Game
  attr_accessor :playing, :board

  def initialize
    @board = UprightBoard.new
    @playing = rand(2)
  end

  def make_players
    puts "═════════════════════════════════════════════════════════════"
    puts "Go for the glory! Go for the score! Go for it: CONNECT FOUR!"
    puts "═════════════════════════════════════════════════════════════",""

    puts "Player 1, what's your name?"
    p1 = gets.chomp
    while p1.size < 3
      puts "Please enter at least 3 letters for your name."
      p1 = gets.chomp
    end
    puts "Player 2, what's your name?"
    p2 = gets.chomp
    while p2.size < 3
      puts "Please enter at least 3 letters for your name."
      p2 = gets.chomp
    end

    Player.new(p1)
    Player.new(p2)
  end

  def game_over(winner)
    win = Player.players[winner]
    puts " ☼ ✶ ˞  Congratulations, " + ( winner == 0 ? "#{win}" : "#{win}") + ", You WON! ✶ ☼ ˞ "
  end

  def play_game
    make_players
    turn_count = 0
    whos_turn = playing

    until board.is_full? do
      turn_count += 1
      puts "════════════════ TURN #{turn_count} ════════════════"
      board.show_field
      who = Player.players[whos_turn]
      puts "Player " + ( whos_turn == 0 ? "#{who}" : "#{who}" ) + ", select column (1 through 7):",""
      column = gets.chomp.to_i

      until column.between?(1, 7) && board.column_empty?(column - 1) do
        puts
        puts "Wrong column number. Select 1 through 7." if !column.between?(1,7)
        puts "This column is full. Please select another." if column.between?(1,7) && !board.column_empty?(column - 1)
        puts "Select column: "
        column = gets.chomp.to_i
      end

      board.add_to_column(column - 1, whos_turn)
      if board.winner?(column - 1)
        board.show_field
        game_over(whos_turn)
        break
      else
        whos_turn == 0 ? whos_turn = 1 : whos_turn = 0
      end
    end

    if board.is_full?
      board.show
      puts "════════════════ It's a Draw! ════════════════"
    end
  end
end

 newgame = Game.new
 newgame.play_game
