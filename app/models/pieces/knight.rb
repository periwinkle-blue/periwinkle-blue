class Knight < Piece
  before_create :set_defaults

  def set_defaults
    self.icon = (self.color == 1) ? "&#9822;" : "&#9816;"
  end

  def valid_move?(x, y)
    # Calculate old move and new move
    x_move = (x_position - x).abs
    y_move = (y_position - y).abs

    # If x or y move is 2 then the next x or y move is 1
    if x_move == 2 || y_move == 2
      if x_move == 2
        # Return true if y is 1
        return y_move == 1 ? true : false
      else
        # Return true if x is 1
        return x_move == 1 ? true : false
      end
    elsif x_move == 1 || y_move == 1
      if x_move == 1
        # Return true if y is 2
        return y_move == 2 ? true : false
      else
        # Return true if x is 2
        return x_move == 2 ? true : false
      end
    end
  end

end
