#encoding: UTF-8


class Piece

  attr_accessor :color, :king

  def initialize(color)
    @color = color
    @king = false
  end

  def symbol
    @color == :red ? '紅' : '黑'
  end

  def king?
    king
  end

end



piece = Piece.new(:black)
piece2 = Piece.new(:red)

puts piece.symbol
puts piece2.symbol
