class King < Piece
  before_create :set_defaults

  def set_defaults
    self.icon = (self.color == 1) ? "&#9818;" : "&#9812;"
  end

  def valid_move?(x, y)
    # Find current absolute value
    x_move = (x_position - x).abs
    y_move = (y_position - y).abs

    # Make sure its on board
    # return false unless is_onboard?(x, y)

    # If king move is larger than 1 return false
    return false if x_move > 1 || y_move > 1

    # Return true if x and y is within 1
    (x_move == 1) || (y_move == 1)
  end
end
