require 'tictactoe'

describe TicTacToe do
  let (:game) { TicTacToe.new }
  before(:each) do
    allow(game).to receive(:puts)
    @gamegets = allow(game).to receive(:gets)
  end

   describe "#play" do
     it "asks for player input on a turn of the game" do
       allow(game).to receive(:over?).and_return(false, true)

       @gamegets.at_least(:once).and_return("1")

       game.play
     end

    it "checks if game is over after every turn" do
      @gamegets.and_return("1", "2", "3")

      expect(game).to receive(:over?).at_least(:twice).and_return(false, false, true)
      game.play
    end

    it "plays the first turn" do
      @gamegets.and_return("1")

      allow(game).to receive(:over?).and_return(false, true)

      game.play
      board_after_first_turn = game.instance_variable_get(:@board)
      expect(board_after_first_turn).to match_array(["X", nil, nil, nil, nil, nil, nil, nil, nil])
    end

    it "plays first few turns" do
      @gamegets.and_return("1", "2", "3")
      allow(game).to receive(:over?).and_return(false, false, false, true)

      game.play

      board_after_first_turn = game.instance_variable_get(:@board)
      expect(board_after_first_turn).to match_array(["X", "O", "X", nil, nil, nil, nil, nil, nil])
    end

    it "checks for win after each turn" do
      @gamegets.and_return("1", "2", "3")
      allow(game).to receive(:winner).and_return("X")

      expect(game).to receive(:won?).at_least(:twice).and_return(false, false, true)
      game.play
    end

    it "checks for a draw after each turn" do
      @gamegets.and_return("1", "2", "3")

      expect(game).to receive(:draw?).at_least(:twice).and_return(false, false, true)
      game.play
    end

    it "stops playing when game won" do
      board = ["X", "X", "X", " ", " ", " ", " ", " ", " "]
      game.instance_variable_set(:@board, board)

      expect(game).to_not receive(:turn)

      game.play

    end

    it "announces winner X" do
      board = ["X", "X", "X", " ", " ", " ", " ", " ", " "]
      game.instance_variable_set(:@board, board)

      expect(game).to receive(:puts).with("X is the winner!")

      game.play
    end

    it "announces winner O" do
      board = [" ", " ", " ", " ", " ", " ", "O", "O", "O"]
      game.instance_variable_set(:@board, board)


      expect(game).to receive(:puts).with("O is the winner!")

      game.play
    end

    it "stops playing when a draw" do
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, board)

        expect(game).to_not receive(:turn)

        game.play
      end

      it "prints 'It's a draw' on a draw" do
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, board)

        expect(game).to receive(:puts).with("It's a draw.")

        game.play
      end

      it "plays through an entire game" do

        expect(game).to receive(:gets).and_return("1")
        expect(game).to receive(:gets).and_return("2")
        expect(game).to receive(:gets).and_return("3")
        expect(game).to receive(:gets).and_return("4")
        expect(game).to receive(:gets).and_return("5")
        expect(game).to receive(:gets).and_return("6")
        expect(game).to receive(:gets).and_return("7")

        expect(game).to receive(:puts).with("X is the winner!")

        game.play
      end
    end
end
