#encoding: UTF-8


class Piece

  MOVES = {
    red:    [[-1, 1], [-1, -1]],
    black:  [[1, 1], [1, -1]],
  }

  ATTACK_MOVES = {
    red: [[-2, 2], [-2, -2]],
    black: [[2, 2], [2, -2]],
  }

  attr_accessor :color, :king, :pos, :board, :moves

  def initialize(pos, color, board, king = nil)

    @pos = pos
    @color = color
    @board = board
    if king.nil?
      @king = false
    else
      @king = king 
    end

    self.board[pos] = self

  end

  def symbol
    return color == :red ? '紅' : '黑' unless king?
    color == :red ? '朱' : '烏'
  end

  def king?
    self.king
  end

  def crown
    @king = true
  end


  def possible_moves
    moves = []
    moves = normal_moves
    moves.concat(attack_moves)
    moves
  end

  def normal_moves
    moves = []
    move_dirs.each_with_index do |(dx, dy), idx|
      new_space = pos[0] + dx, pos[1] + dy
      if board.in_board?(new_space) && board.empty_space?(new_space)
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
      if board.in_board?(new_space) && board.empty_space?(new_space)
        next unless board[taken].nil? || board[taken].color == color
        attack_moves << new_space
      end
    end
    attack_moves
  end


  def move_to(end_pos)
    @board[pos] = nil
    @pos = end_pos
    @board[end_pos] = self
  end


  def perform_slide(end_pos)
    raise "You can't do that! Invalid move" unless normal_moves.include?(end_pos)
    self.move_to(end_pos)
  end


  def perform_jump(end_pos)
    raise "Invalid move" unless attack_moves.include?(end_pos)
    taken = find_taken_piece(pos, end_pos)
    raise "CKY, dude!" if board[taken].color == color
    board[taken] = nil
    self.move_to(end_pos)
  end



  def perform_moves!(end_pos)
    if end_pose.length < 2
      begin
      return perform_slide(end_pos)

      rescue StandardError
        return perform_jump(end_pos)
      end
    end

    end_pos.each do |move|
      perform_jump(move)
    end
  end


  def valid_move_seq?(end_pos)
    dup_board = board.dup
  end



  def dup(dup_board)
    dup_piece = Piece.new(pos, color, dup_board, king)
    dup_piece
  end














  def find_taken_piece(start_pos, end_pos)
    taken = []
    s_row, s_col = pos
    e_row, e_col = end_pos
    taken << (s_row + e_row) / 2
    taken << (s_col + e_col) / 2
  end





  def move_dirs
    return MOVES[color] unless king?
    MOVES[:red] + MOVES[:black]
  end

  def attack_move_dirs
    return ATTACK_MOVES[color] unless king?
    ATTACK_MOVES[:red] + ATTACK_MOVES[:black]
  end




end
