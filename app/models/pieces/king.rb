class King < Piece
  before_create :set_defaults

  def set_defaults
    self.moved = false
    self.icon = (self.color == 1) ? "&#9818;" : "&#9812;"
  end

  def valid_move?(x, y)
    # Valid parameters passed in?
    valid_params = super
    return false unless valid_params

    is_valid_one_square_move?(x, y)
  end

  def valid_capture?(x, y)
    return self.valid_move?(x, y)
  end

  def will_cause_check?(x, y)
    opposing_pieces = self.game.get_active_opposing_pieces(self.color)

    opposing_pieces.each do |piece|
      return true if piece.valid_capture?(x, y)
    end

    return false
  end

  private
  
  def is_valid_one_square_move?(x, y)
    # Calculate old move and new move
    x_move = (x_position - x).abs
    y_move = (y_position - y).abs

    # Return true if x and y is less than 2
    (x_move < 2) &&
    (y_move < 2)
  end



end
