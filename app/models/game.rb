class Game < ActiveRecord::Base
  after_create :initialize_board
  
  has_many :pieces
  belongs_to :white_player, class_name: "User"
  belongs_to :black_player, class_name: "User"
  
  def find_piece_icon(x,y)
    piece = self.pieces.where( :x_position => x, :y_position => y).first
    return (!piece.nil?) ? piece.icon.html_safe : ""
  end
  
  # Initialze board with 16 chess pieces to start the game
  def initialize_board
    puts "In initialize board"
    
    Piece.delete_all
    
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
    King.create( :x_position => 0, :y_position => 3, :color => 0, :game => self)
    King.create( :x_position => 7, :y_position => 3, :color => 1, :game => self)
    Queen.create( :x_position => 0, :y_position => 4, :color => 0, :game => self)
    Queen.create( :x_position => 7, :y_position => 4, :color => 1, :game => self)
    
  end
  
end
