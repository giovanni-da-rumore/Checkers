#encoding: UTF-8

require_relative 'piece'
require 'colorize'



class Board

  attr_accessor :grid


  def initialize(grid = nil)
    grid = make_grid if grid.nil?
    @grid = grid
  end


  def make_grid
    Array.new(8) {Array.new(8)}
  end

  def self.set_board
    board = Board.new
    board.populate
    board
  end

  def populate
    self.grid.each_with_index do |row, idx|
      row.each_with_index do |space, col|
        if idx % 2 == 0 && col % 2 == 0 && idx < 3
          Piece.new([idx, col], :black, self)
        elsif idx % 2 == 1 && col % 2 == 1 && idx < 3
          Piece.new([idx, col], :black, self)
        elsif idx % 2 == 1 && col % 2 == 0 && idx > 4
          Piece.new([idx, col], :red, self)
        elsif idx % 2 == 0 && col % 2 == 1 && idx > 4
          Piece.new([idx, col], :red, self)
        end
      end
    end
  end



  def all_pieces
    grid.flatten.compact
  end

  def []=(pos, piece)
    x, y = pos[0], pos[1]
    self.grid[x][y] = piece
  end



  def [](pos)
    x, y = pos[0], pos[1]
    self.grid[x][y]
  end


  def []=(pos, piece)
    x, y = pos[0], pos[1]
    self.grid[x][y] = piece
  end


  def empty_space?(pos)
    self[pos].nil?
  end


  def perform_slide(start_pos, end_pos)
    piece = self[start_pos]
    raise "Start Position empty" if piece.nil?

    piece.moves
  end


  def render
    puts "   #{[1,2,3,4,5,6,7,8].join('  ')}"

    grid.each_with_index do |row, idx|
      row.each_with_index do |piece, col|
        if piece
          row[col] = piece.symbol
        else
          row[col] = '--'
        end
      end
      puts "#{idx + 1 }: #{row.join(' ')}"
    end
  end
end






board = Board.set_board




#piece = Piece.new([0,0], :black, board)
#piece2 = Piece.new([4,4], :red, board)

#puts piece.symbol
#p piece.possible_moves
#puts piece2.symbol
#p piece2.possible_moves


puts board[[4,4]]
puts
#p board
board.render

#
# p String.modes
#
# p
#
# p String.color_samples
#
# count = 0
#   handle = 2
# while count < 63
#   if count % 2 == hanlde
#
#   if (count + 1) % 8 = 0
#     handle = (handle == 2 ? 1 : 2)
#   end
#   count += 1
#
