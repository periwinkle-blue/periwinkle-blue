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
    puts "UPDATING TURN!"
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

  def king_in_check
    # Get pieces from database
    pieces.find_each do |piece|
      # Loop through positions on board to verify valid moves
      for x in 0..7
        for y in 0..7
          # Check to see if target position is valid
          if piece.valid_move?(x, y)
            # Check piece on position
            king_check = piece_on(x, y)
            # Piece on position was not nil, is a king, and is opposite color from original piece
            if !king_check.nil? && king_check.type == "King" && king_check.color != piece.color
              # Check if king is in checkmate or just in check
              if king_check.color == 0
                return checkmate?(x, y) ? "white_checkmate" : "white_in_check"
              end

              if king_check.color == 1
                return checkmate?(x, y) ? "black_checkmate" : "black_in_check"
              end
            end
          end

        end
      end

    end
    # King is all good
    return false
  end

  # Receive current position for king
  def checkmate?(king_x, king_y)
    king = pieces.where(:x_position => king_x, :y_position => king_y).first
    # Variable to help determine if all the positions are in check
    king_checkmate = 0

    # Get the range for the loop
    x_start = king_x - 1
    x_end = x_start + 2
    y_start = king_y - 1
    y_end = y_start + 2

    # Start from top left position for king
    for x in x_start..x_end
      for y in y_start..y_end
        # Pass in possible moves to check if it will cause a check
        if king.will_cause_check?(x, y)
          king_checkmate += 1
        end
      end
    end
    # Minus 1 for king's position
    return (king_checkmate - 1) == 8 ? true : false
  end

end
