class Knight < Piece
  before_create :set_defaults
  
  def set_defaults
    self.moved = false
    self.icon = (self.color == 1) ? "&#9822;" : "&#9816;"
  end
end