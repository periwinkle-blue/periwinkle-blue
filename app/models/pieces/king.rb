class King < Piece
  before_create :set_defaults
  
  def set_defaults
    self.icon = (self.color == 1) ? "&#9818;" : "&#9812;"
    self.first_move ||= true
  end
end