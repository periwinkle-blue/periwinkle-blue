class Pawn < Piece
  before_create :set_defaults
  
  def set_defaults
    self.icon = (self.color == 1) ? "&#9823;" : "&#9817;"
  end

end