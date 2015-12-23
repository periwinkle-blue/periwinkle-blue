class Queen < Piece
  before_create :set_defaults
  
  def set_defaults
    self.icon = (self.color == 1) ? "&#9819;" : "&#9813;"
    self.first_move ||= true
  end
  
  def valid_move?(x, y)
    # Valid parameters passed in?
    valid_params = super
    return false if !valid_params
    
    x_diff = (self.x_position - x).abs
    y_diff = (self.y_position - y).abs
    
    # Valid diagonal move?
    return true if x_diff == y_diff and !self.is_obstructed?(x,y)

    # Valid horizontal or vertical move?
    return true if x_diff * y_diff == 0 and !self.is_obstructed?(x,y)

    false
  end

end