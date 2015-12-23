class King < Piece
  before_create :set_defaults

  def set_defaults
    self.icon = (self.color == 1) ? "&#9818;" : "&#9812;"
    self.first_move ||= true
  end

  def valid_move?(x, y)
    # Calculate old move and new move
    x_move = (x_position - x).abs
    y_move = (y_position - y).abs

    # Return true if x and y is less than 2
    return (x_move < 2) && (y_move < 2) ? true : false
  end

end
