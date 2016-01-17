class Game < ActiveRecord::Base
  require 'piece'
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
<<<<<<< HEAD

=======
  
  def get_active_opposing_pieces(color)
    opposing_color = (color == 1) ? 0 : 1
    self.pieces.where(:color => opposing_color).to_a
  end
  
>>>>>>> master
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

  # Loop through board to check pieces for valid moves
  def king_in_check?
    piece = Piece.new

    for x in 0..7
      for y in 0..7
        # Check for piece in database
        piece = self.pieces.where(:x_position => x, :y_position => y).first

        if !piece.nil?
          for position in 0..7
            # Check piece in position for valid moves
            check_king_horizontal = piece_on(x, position)
            check_king_vertical = piece_on(position, y)
            check_king_top_left = piece_on(x - position, y - position)
            check_king_top_right = piece_on(x - position, y + position)
            check_king_bottom_left = piece_on(x + position, y - position)
            check_king_bottom_right = piece_on(x + position, y + position)

            if piece.valid_move?(x, position) ||
               piece.valid_move?(position, y) ||
               piece.valid_move?(x - position, y - position) ||
               piece.valid_move?(x - position, y + position) ||
               piece.valid_move?(x + position, y - position) ||
               piece.valid_move?(x + position, y + position)

              # If position is not nil, check to see if its the opposite king
              if !check_king_horizontal.nil?
                return true if check_king_horizontal.type == "King" &&
                        check_king_horizontal.color != piece.color

              elsif !check_king_vertical.nil?
                return true if check_king_vertical.type == "King" &&
                        check_king_vertical.color != piece.color

              elsif !check_king_top_left.nil?
                return true if check_king_top_left.type == "King" &&
                        check_king_top_left.color != piece.color

              elsif !check_king_top_right.nil?
                return true if check_king_top_right.type == "King" &&
                        check_king_top_right.color != piece.color

              elsif !check_king_bottom_left.nil?
                return true if check_king_bottom_left.type == "King" &&
                        check_king_bottom_left.color != piece.color

              elsif !check_king_bottom_right.nil?
                return true if check_king_bottom_right.type == "King" &&
                        check_king_bottom_right.color != piece.color

              elsif position == 7
                return false
              end
            end
          end
        end

      end
    end

	end # king_in_check?

end
