require_relative "board"
require_relative 'player'

class Game

  attr_accessor :player1, :player2, :board

  def initialize(board)
    @board = board
    @player1 = HumanPlayer.new(board)
    @player2 = HumanPlayer.new(board)
  end


  def won?
    player1.valid_moves.length < 1 || player2.valid_moves.length < 1
  end


  def play
    player1.select_color
    player1.color == :red ? @player2.color = :black : player2.color = :red

    puts "Red goes first"
    current_player = (player1.color == :red ? player1 : player2)

    until won?
      board.render

      current_player.make_move
      board.all_pieces.each {|piece| piece.tyrannic?}
      current_player = (current_player == player1 ? player2 : player1)
    end
    "#{current_player.color.capitalize} wins!"
  end


end


board = Board.set_board
board.render
game = Game.new(board)
game.play
