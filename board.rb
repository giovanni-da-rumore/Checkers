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
        if idx % 2 == 0 && col % 2 == 1 && idx < 3
          Piece.new([idx, col], :black, self)
        elsif idx % 2 == 1 && col % 2 == 0 && idx < 3
          Piece.new([idx, col], :black, self)

        elsif idx % 2 == 1 && col % 2 == 0 && idx > 4
          Piece.new([idx, col], :red, self)
        elsif idx % 2 == 0 && col % 2 == 1 && idx > 4
          Piece.new([idx, col], :red, self)
        end
      end
    end
  end


  def in_board?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end


  def all_pieces
    grid.flatten.compact
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


  def dup
    dup_board = Board.new
    p dup_board

    grid.flatten.each_with_index do |piece, idx|
      dup_board[[(idx / 8), (idx % 8)]] = piece.dup(dup_board) unless piece.nil?
    end
    dup_board
  end





  def render
    handle = 0
    puts "   #{[1,2,3,4,5,6,7,8].join('  ')}"
    grid.each_with_index do |row, idx|
      display_row = row.dup
      display_row.each_with_index do |piece, col|
        if piece
          display_row[col] = piece.symbol.colorize(:red) if piece.color == :red
          display_row[col] = piece.symbol if piece.color == :black
        else
          if col % 2 == handle
            display_row[col] = '--'.colorize(:light_red)
          else
            display_row[col] = '--'.colorize(:light_black)
          end
        end
      end
      handle = (handle == 0 ? 1 : 0)

      puts "#{idx + 1 }: #{display_row.join(' ')}"
    end
  end

end





#
# board = Board.set_board
# board.render

#
#
#
# #
# piece = Piece.new([2,1], :black, board)
# piece2 = Piece.new([4,5], :black, board)
# piece3 = Piece.new([5,4], :red, board)
# piece4 = Piece.new([2,1], :black, board)
#
# #
# # p piece4.possible_moves
# #
#
# p piece2.possible_moves
#
# board.render
# nb = board.dup
#
# nb.render
# piece3.perform_jump([3,6])
#
# piece.perform_slide([3,2])
# #
#  puts
# # board.render
# board.render
# puts
#
# nb.render
#
