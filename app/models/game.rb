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

  def king_in_check?(type, color)
    @king = self.pieces.where(:type => 'King', :color => color).first

    find_king_obstruction(@king.x_position, @king.y_position, @king.color)
  end

  def find_king_obstruction(x, y, color)
    @left = self.pieces.where(:x_position => (x - 1), :y_position => y).first

    # Check king left horizontal position until 0 or obstructed for queen or rook
    while x != 0

      # Check if piece is on
      if @left.type == "Queen" && @left.color != color
        # Return true for check
        return @left.type
      elsif @left.type == "Rook" && @left.color != color
        # Return true for check
        return @left.type
      end

      # Update loop
      x -= 1

    end

  end

=begin

    # Check king right horizontal position until 7 or obstructed for queen or rook
    while x != 7
      # Check if piece is on
      if find_piece_icon(x, y)
        if piece.type == "Queen" && piece.color != color
          # Return true for check
          return true
        elsif piece.type == "Rook" && piece.color != color
          # Return true for check
          return true
        else
          # Not checked
          return false
        end
      end
      # Update loop
      x += 1
    end

    # Check king top vertical until 0 or obstructed for queen or rook
    while y != 0
      # Check if piece is on
      if find_piece_icon(x, y)
        if piece.type == "Queen" && piece.color != color
          # Return true for check
          return true
        elsif piece.type == "Rook" && piece.color != color
          # Return true for check
          return true
        else
          # Not checked
          return false
        end
      end
      # Update loop
      y -= 1
    end

    # Check king bottom vertical until 7 or obstructed for queen or rook
    while y != 7
      # Check if piece is on
      if find_piece_icon(x, y)
        if piece.type == "Queen" && piece.color != color
          # Return true for check
          return true
        elsif piece.type == "Rook" && piece.color != color
          # Return true for check
          return true
        else
          # Not checked
          return false
        end
      end
      # Update loop
      y += 1
    end

=end


  # Find pieces to see if king is in check
#  def king_in_check?(x, y, color)
    #king_0 = find_king("King", 0)
    #king_1 = find_king("King", 1)

    #king_0_target = find_target_square(king_0.x_position, king_0.y_position, king_0.color)

    # Check Rook
    #king_0.is_obstructed?(x, y)
    #king_1.is_obstructed?(x, y)

    # Check if Bishop
    # Check if Knight
    # Check if Pawn
    # Check if King

#  end

  # Find piece on target square
  #def find_piece_on(x, y)
  #  @piece_type = self.pieces.where(:x_position => x, :y_position => y).first
  #  return @piece_type
  #end

  # Find the target square to pass to is_obstructed
#  def find_target_square(x, y, color)


#  end

end
