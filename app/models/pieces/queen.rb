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
    
    is_valid_diagonal_move?(x, y) || 
      is_valid_horizontal_or_vertical_move?(x, y) 
  end
  
  def valid_capture?(x, y)
    return self.valid_move?(x, y)
  end
  
end