class Pawn < Piece
  before_create :set_defaults
  #attr_accessor :first_move
  
  def set_defaults
    self.moved = false
    self.icon = (self.color == 1) ? "&#9823;" : "&#9817;"
  end
  
  def valid_move?(x, y)
    # Valid parameters passed in?
    valid_params = super
    return false unless valid_params
    
    return true if is_valid_two_space_move?(x,y) || 
                   is_valid_one_space_move?(x,y) || 
                   is_valid_diagonal_capture?(x,y)
    
    return false
    
  end
  
  private
  
  def is_valid_two_space_move?(x, y)
    x_diff = self.x_position - x
    y_diff = self.y_position - y
    
    if x_diff == 2 and y_diff == 0
      return true if !self.moved and !self.game.piece_on(x,y) and !self.is_obstructed?(x,y)
    end
    
    return false
  end
  
  def is_valid_one_space_move?(x, y)
    x_diff = self.x_position - x
    y_diff = self.y_position - y
    
    if x_diff == 1 and y_diff == 0
      return true if !self.game.piece_on(x,y)
    end
    
    return false
  end
  
  def is_valid_diagonal_capture?(x, y)
    x_diff = self.x_position - x
    y_diff = self.y_position - y
    
    if x_diff == 1 and (y_diff == 1 or y_diff == -1)
      piece = self.game.piece_on(x,y)
      if !piece.nil?
        # Depending on how we eventually do the capture check, this color difference check may change
        return true if self.game.piece_on(x,y).color != self.color
      end
    end
    
    return false
  end
  
end