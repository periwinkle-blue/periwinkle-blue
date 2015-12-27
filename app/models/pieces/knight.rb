class Knight < Piece
  before_create :set_defaults

  def set_defaults
    self.moved = false
    self.icon = (self.color == 1) ? "&#9822;" : "&#9816;"
  end

  def valid_move?(x, y)
    # Calculate old move and new move
    x_move = (x_position - x).abs
    y_move = (y_position - y).abs

    return valid_move_combination?(x_move, y_move)
  end

  def valid_move_combination?(x_move, y_move)
    return (x_move == 2 && y_move == 1) || (x_move == 1 && y_move ==2) ? true : false
  end

end
