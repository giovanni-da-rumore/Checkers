class HumanPlayer

  attr_accessor :color, :board


  def initialize(board)
    @board = board
    @color = nil
  end



  def select_color
    begin
      puts "Would you like to be red or black? r/b"
      choice = gets.chomp.downcase
      raise "Invalid option, please press 'r' or 'b'" if choice != 'r' && choice != 'b'
      choice == 'r' ? @color = :red : @color = :black

    rescue
      retry
    end
  end


  def make_move

      puts "Please select a piece to move: row,col"
      piece = gets.chomp.split(',').map {|coord| coord.to_i}
      piece = board[piece]

      raise "Empty Space!" if piece.class != Piece
      raise "That's not your piece, dude" if piece.color != color

      puts "Please select a place to move: row,col"
      end_pos = gets.chomp.split(',').map {|coord| coord.to_i}

      puts


      piece.perform_moves(end_pos)

      puts "Invalid Move! Please try again"


  end




  def valid_moves
    pieces = board.all_pieces.select! {|piece| piece.color == color}
    moves = {}
    pieces.each do |piece|
      moves[piece] = piece.possible_moves unless piece.possible_moves.length < 1
    end
    moves
  end



end
