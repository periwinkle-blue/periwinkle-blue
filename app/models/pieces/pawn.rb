class Pawn < Piece
  before_create :set_defaults

  def set_defaults
    # 1 - black (bottom), 0 - white (top)
    self.moved = false
    self.direction = (self.color == 1) ? 1 : -1
    self.icon = (self.color == 1) ? "&#9823;" : "&#9817;"
  end
  
  def valid_move?(x, y)
    # Valid parameters passed in?
    valid_params = super
    return false unless valid_params
    
    @promote_pawn = can_promote?(x, y)

    if is_valid_two_square_move?(x,y) || 
    is_valid_one_square_move?(x,y) || 
      valid_capture?(x,y)
        return true
    end

  end

  def valid_capture?(x, y, attempt_capture = nil)
    x_diff = self.x_position - x
    y_diff = self.y_position - y
    
    if x_diff == (1 * get_direction) and (y_diff == 1 or y_diff == -1)
      return true
    end
    
    return false
  end

  private

  def can_promote?(x, y)
    return true if (x == 0 && self.color == 1) || (x == 7 && self.color == 0)
  end
  
  def get_direction
    self.color == 1 ? 1 : -1
  end
  
  def is_valid_two_square_move?(x, y)
    x_diff = self.x_position - x
    y_diff = self.y_position - y
    
    if x_diff == (2 * get_direction) and y_diff == 0
      return true if !self.moved and !self.game.piece_on(x,y)# and !self.is_obstructed?(x,y)
    end
    
    return false
  end
  
  def is_valid_one_square_move?(x, y)
    x_diff = self.x_position - x
    y_diff = self.y_position - y
    
    if x_diff == (1 * get_direction) and y_diff == 0
      return true if !self.game.piece_on(x,y)
    end
    
    return false
  end
      
end