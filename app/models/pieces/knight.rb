class Knight < Piece
  before_create :set_defaults

  def set_defaults
    self.icon = (self.color == 1) ? "&#9822;" : "&#9816;"
  end

  def valid_move?(x, y)
    # Calculate old move and new move
    x_move = (x_position - x).abs
    y_move = (y_position - y).abs

=begin
    # Calculate knight top move limited to 1 and left move is 0
    if x_move == 1

    # Calculate knight full move top or bottom
    if x_move == 2
        # Return true if x is 2 and y is 1
        return (x_move == 2) && (y_move == 1) ? true : false
    end

    # Calculate knight full move left or right
    if y_move == 2
        # Return true if y is 2 and x is 1
        return (y_move == 2) && (x_move == 1) ? true : false
    end

    # None of the moves were valid
    return false
  end
=end
end
