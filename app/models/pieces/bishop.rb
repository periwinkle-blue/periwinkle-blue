class Bishop < Piece
  before_create :set_defaults
  
  def set_defaults
    self.icon = (self.color == 1) ? "&#9821;" : "&#9815;"
  end
end