class Bishop < Piece
  before_create :set_defaults
  
  def set_defaults
    self.moved = false
    self.icon = (self.color == 1) ? "&#9821;" : "&#9815;"
  end
  
  def valid_move?(x, y)
    # Valid parameters passed in?
    valid_params = super
    return false unless valid_params
    
    return true if is_valid_diagonal_move?(x, y) and !taking_own_piece?(x,y)
  end

  def valid_capture?(x, y)
    return self.valid_move?(x, y)
  end

end