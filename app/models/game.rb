class Game < ActiveRecord::Base
  after_create :initialize_board
  
  has_many :pieces
  belongs_to :white_player, class_name: "User"
  belongs_to :black_player, class_name: "User"
  
  def find_piece_icon(x,y)
    #piece = self.pieces.where( :x_position => x, :y_position => y).first
    piece = piece_on(x,y)
    return (!piece.nil?) ? piece.icon.html_safe : ""
  end
  
  def piece_on(x,y)
    return self.pieces.where( :x_position => x, :y_position => y).first
  end
  
  def get_active_opposing_pieces(color)
    opposing_color = (color == 1) ? 0 : 1
    self.pieces.where(:color => opposing_color).to_a
  end
  
  # Initialze board with 16 chess pieces to start the game
  def initialize_board
    
    # Create Pawns
    8.times do |index|
      Pawn.create( :x_position => 1, :y_position => index, :color => 0, :game => self)
      Pawn.create( :x_position => 6, :y_position => index, :color => 1, :game => self)
    end
    
    # Create Rooks, Knights, Bishops
    2.times do |index|
      Rook.create( :x_position => 0, :y_position => index * 6 + index, :color => 0, :game => self)
      Rook.create( :x_position => 7, :y_position => index * 6 + index, :color => 1, :game => self)
      Knight.create( :x_position => 0, :y_position => index * 5 + 1, :color => 0, :game => self)
      Knight.create( :x_position => 7, :y_position => index * 5 + 1, :color => 1, :game => self)
      Bishop.create( :x_position => 0, :y_position => index * 3 + 2, :color => 0, :game => self)
      Bishop.create( :x_position => 7, :y_position => index * 3 + 2, :color => 1, :game => self)
    end
    
    # Create Kings and Queens
    Queen.create( :x_position => 0, :y_position => 3, :color => 0, :game => self)
    Queen.create( :x_position => 7, :y_position => 3, :color => 1, :game => self)
    King.create( :x_position => 0, :y_position => 4, :color => 0, :game => self)
    King.create( :x_position => 7, :y_position => 4, :color => 1, :game => self)
    
  end
  
  # For testing
  def clear_board!
    self.pieces.delete_all
  end
  
  # Switch turns to the opposing user
  def update_turn
    self.turn == self.white_player_id ? self.turn = self.black_player_id : self.turn = self.white_player_id
    self.save
  end
  
  def get_current_turn_message(user_id)
    if user_id == self.turn
      message = "Your turn!"
    else
      message = "Waiting on #{User.find(self.turn).email}"
    end
  end
  
#  def in_checkmate?(player)
#    player_color = ( player == self.white_player_id ) ? 0 : 1
#    player_king = self.pieces.where( :color => player_color, :type => "King").first
#    
#    surrounding_squares = player_king.get_surrounding_squares
#    puts "Surrounding squares: #{surrounding_squares}"
#    surrounding_squares.each { |square| return false unless player_king.will_cause_check?(square[0], square[1])}
#    
#    return true
#  end
  
end
