class Bishop < Piece
  before_create :set_defaults
  
  def set_defaults
    self.icon = (self.color == 1) ? "&#9821;" : "&#9815;"
  end

  def valid_move?(x,y)
  	return false unless ((x_position - x) / (y_position - y)) == 1 or -1
  end
end