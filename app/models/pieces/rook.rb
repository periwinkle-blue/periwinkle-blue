class Rook < Piece
  before_create :set_defaults
  
  def set_defaults
    self.icon = (self.color == 1) ? "&#9820;" : "&#9814;"
    self.first_move ||= true
  end

  def valid_move?(x,y)
  	if x_position == x || y_position == y
  		return true
  	else 
  		return false
  	end

  end

end