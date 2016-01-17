class Knight < Piece
  before_create :set_defaults

  def set_defaults
    self.moved = false
    self.icon = (self.color == 1) ? "&#9822;" : "&#9816;"
  end

  def valid_move?(x, y)
    # Valid parameters passed in?
    valid_params = super
    return false unless valid_params
    
    is_valid_move_combination?(x, y)
  end

  def is_valid_move_combination?(x, y)
    # Calculate old move and new move
    x_move = (x_position - x).abs
    y_move = (y_position - y).abs

    (x_move == 2 && y_move == 1) || 
      (x_move == 1 && y_move ==2)
  end
  
  def valid_capture?(x, y)
    return self.valid_move?(x, y)
  end

end
