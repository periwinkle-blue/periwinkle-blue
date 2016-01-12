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
    
    is_valid_diagonal_move?(x, y)
  end
  
end