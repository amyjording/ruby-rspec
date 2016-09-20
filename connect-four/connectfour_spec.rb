require 'connectfour'

describe Player do
  subject(:player) { Player.new("Joe") }

  it "exists" do
    expect(player).not_to be_nil
  end

  context "if no name specified" do
    it "can name player by default" do
      Player.new
      expect( Player.players[1] ).to eql("Joe")
    end
  end

  context "creates two players" do
    it "stores player names into class variable" do
      expect( Player.players.size ).to eql(4)
      expect( Player.players[0] ).to eql("Joe")
    end
  end
end

describe UprightBoard do
  subject(:board) { UprightBoard.new }

  it "exists" do
    expect(board).not_to be_nil
  end

  context "has @columns variable" do
    it "initializes" do
      expect(board.instance_variable_get(:@columns)).not_to be_nil
    end

    it "readable from outside of object" do
      expect(board).to respond_to(:columns)
    end

    it "initialized as array" do
      expect(board.columns).to be_an(Array)
    end

    it "filled with 7 empty arrays" do
      expect(board.columns.size).to eql(7)
    end
  end

  describe "#column_empty?" do
    it "checks for 0 to 6 columns" do
      expect(board.column_empty?(7)) == false
    end

    it "verifies less than 6 elements" do
      expect(board.column_empty?(1)) == true
    end

    it "determines false for 6 or more elements" do
      6.times { board.columns[1] << "X" }
      expect(board.column_empty?(1)) == false
    end
  end

  describe "add_to_column" do
    it "adds player number to column" do
      expect{ board.add_to_column(1, 1) }.to change{ board.columns[1].size }.from(0).to(1)
    end

    it "returns false if column has more than 5 elements" do
      6.times { board.columns[1] << "♥" }
      expect( board.add_to_column(1, 1) ) == false
    end
  end

  describe "show_field" do
    it "shows board current play status" do
      3.times { board.columns[2] << 1 }
      3.times { board.columns[4] << 0 }
      expect(board.show_field) == true
    end
  end

  describe "winner?" do
    it "returns true if winning combination" do
      4.times { board.columns[1] << 1 }
      expect( board.winner?(1) ) == true
    end

    it "returns false if no winning combination" do
      2.times { board.columns[1] << 1 }
      board.columns[1] << 0
      2.times { board.columns[1] << 1 }
      expect(board.winner?(1)) == false
    end
  end

  describe "check_diag" do
    context "contain winning combination" do
      it "returns true if upper left to lower right" do
        4.times { board.columns[1] << 1 }
        3.times { board.columns[2] << 1 }
        4.times { board.columns[3] << 1 }
        4.times { board.columns[4] << 1 }
        expect(board.check_diag(2, 2) ) == true
      end
      it "returns true if lower left to upper right" do
        4.times { board.columns[1] << 1 }
        4.times { board.columns[2] << 1 }
        3.times { board.columns[3] << 1 }
        4.times { board.columns[4] << 1 }
        expect(board.check_diag(3,2)) == false
      end
      it "returns false if diagonals do not" do
        4.times { board.columns[1] << 1 }
        4.times { board.columns[2] << 0 }
        2.times { |x| 4.times { board.columns[x + 3] << 1} }
        expect(board.check_diag(1,3)) == false
      end
    end
  end

  describe "is_full?" do
    it "returns true if all fields are filled" do
      7.times { |x| 6.times {board.columns[x] << 1} }
      expect(board.is_full?) == false
    end
  end
end

describe Game do
  subject(:game) { Game.new }

  it "exists" do
    expect(game).to_not be_nil
  end

  context "has @board variable" do
    it "initializes on deploy" do
      expect(game.instance_variable_get(:@board)).not_to be_nil
    end

    it "can be read outside object" do
      expect(game).to respond_to(:board)
    end

    it "initializes players number of 0 or 1" do
      expect([0,1]).to include(game.playing)
    end
  end
end
