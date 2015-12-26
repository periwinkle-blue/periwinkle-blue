class Rook < Piece
  before_create :set_defaults
  
  def set_defaults
    self.moved = false
    self.icon = (self.color == 1) ? "&#9820;" : "&#9814;"
  end

  def valid_move?(x,y)
  	valid_params = super
	return false if !valid_params

  	return true if x_position == x || y_position == y and ! is_obstructed?(x,y)
  	false
  end

end