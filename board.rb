#encoding: UTF-8

require_relative 'piece'
require 'colorize'



class Board

  attr_accessor :grid


  def initialize
    @grid = make_grid
  end


  def make_grid
    Array.new(8) {Array.new(8)}
  end


  # def populate
  #   grid.each_with_index do |row, x|
  #     row.each_with_index do |el, y|
  #
  #             self[[x, y]] = Piece.new([x, y], :black, self)
  #           end
  #         end
  #       end
  #     end
  #   end
  # end



  def all_spaces
    #grid.flatten.compact
    grid.each_with_object([]) do |row, ray|
      row.each do |col|
        ray << col
      end
    end
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






board = Board.new
board.populate



piece = Piece.new([0,0], :black, board)
piece2 = Piece.new([4,4], :red, board)

#puts piece.symbol
#p piece.possible_moves
#puts piece2.symbol
#p piece2.possible_moves


puts board[[4,4]]
puts
#p board
board.render







b = Board.new
