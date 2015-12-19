class King < Piece
  before_create :set_defaults

  belongs_to :piece

  def set_defaults
    self.icon = (self.color == 1) ? "&#9818;" : "&#9812;"
  end

  def valid_move?(x, y)
    # Calculate old move and new move
    x_move = (x_position - x).abs
    y_move = (y_position - y).abs

    # Is x or y 1?
    return (x_move == 1) || (y_move == 1) ? true : false
  end

end
