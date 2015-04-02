#encoding: UTF-8

require_relative 'piece'
require 'colorize'



class Board

  attr_accessor :grid


  def initialize
    @grid = make_grid
  end


  def make_grid
    grid = Array.new(10) {Array.new(10)}
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
    piece = board[start_pos]
    raise "Start Position empty" if piece.nil?

    piece.moves
  end


    # raise "Invalid Move!"  unless
    #   board[start_pos].moves.include?(end_pos)
    #




end



board = Board.new
piece = Piece.new([0,0], :black, board)
piece2 = Piece.new([4,4], :red, board)

puts piece.symbol
p piece.possible_moves
puts piece2.symbol
p piece2.possible_moves









b = Board.new
