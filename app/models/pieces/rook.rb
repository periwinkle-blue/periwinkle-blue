class Rook < Piece
  before_create :set_defaults
  
  def set_defaults
    self.icon = (self.color == 1) ? "&#9820;" : "&#9814;"
  end

end