#encoding: UTF-8


class Piece

  MOVES = {
    red:    [[-1, 1], [-1, -1]],
    black:  [[1, 1], [-1, -1]],
    king:   [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  }

  ATTACK_MOVES = {
    red: [[-2, 2], [-2, -2]],
    black: [[2, 2], [-2, -2]],
    king: [[2, 2], [2, -2], [-2, 2], [-2, -2]]
  }

  attr_accessor :color, :king, :pos, :board, :moves

  def initialize(pos, color, board)

    @pos = pos
    @color = color
    @board = board
    @king = false
    @moves = []
  end

  def symbol
    return color == :red ? '紅' : '黑' unless king?
    color == :red ? '朱' : '烏'
  end

  def king?
    king
  end

  def crown
    @king = true
  end


  def possible_moves
    self.moves = normal_moves
    moves.concat(attack_moves)
  end

  def normal_moves
    self.moves = []
    move_dirs.each_with_index do |(dx, dy), idx|
      new_space = pos[0] + dx, pos[1] + dy
      if in_board?(new_space) && board.empty_space?(new_space)
        moves << new_space
      end
    end
    moves
  end

  def attack_moves
    attack_moves = []
    attack_move_dirs.each_with_index do |(dx, dy), idx|
      new_space = pos[0] + dx, pos[1] + dy
      taken = move_dirs[idx]
      if in_board?(new_space) && board.empty_space?(new_space)
        next if board[taken].nil?
          moves << new_space
      end
    end
    attack_moves

  end




  def perform_jump
  end



  def move_dirs
    return MOVES[color] unless king?
    MOVES[king]
  end

  def attack_move_dirs
    return ATTACK_MOVES[color] unless king?
    ATTACK_MOVES[king]
  end

  def in_board?(pos)
    pos[0].between?(0,9) && pos[1].between?(0,9)
  end



end
