class Queen < Piece
  before_create :set_defaults
  
  def set_defaults
    self.icon = (self.color == 1) ? "&#9819;" : "&#9813;"
  end

end