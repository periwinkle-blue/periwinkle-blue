class Rook < Piece
  before_create :set_defaults
  
  def set_defaults
    self.moved = false
    self.icon = (self.color == 1) ? "&#9820;" : "&#9814;"
  end

  def valid_move?(x,y)
  	valid_params = super
	return false unless valid_params

  	return true if is_valid_horizontal_or_vertical_move?(x, y)
  	false
  end

  def is_valid_horizontal_or_vertical_move?(x, y)
  	self.x_position == x || self.y_position == y and !self.is_obstructed?(x,y)
  end

end