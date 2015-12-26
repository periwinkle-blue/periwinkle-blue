class Queen < Piece
  before_create :set_defaults
  
  def set_defaults
    self.moved = false
    self.icon = (self.color == 1) ? "&#9819;" : "&#9813;"
  end
  
  def valid_move?(x, y)
    # Valid parameters passed in?
    valid_params = super
    return false unless valid_params
    
    return true if is_valid_diagonal_move?(x, y)
    return true if is_valid_horizontal_or_vertical_move?(x, y)

    false
  end
  
  def is_valid_diagonal_move?(x, y)
    x_diff = (self.x_position - x).abs
    y_diff = (self.y_position - y).abs
    
    if x_diff == y_diff and !self.is_obstructed?(x,y)
      return true
    else
      return false
    end
  end
  
  def is_valid_horizontal_or_vertical_move?(x, y)
    x_diff = (self.x_position - x).abs
    y_diff = (self.y_position - y).abs
    
    if x_diff * y_diff == 0 and !self.is_obstructed?(x,y)
      return true
    else
    end
  end

end