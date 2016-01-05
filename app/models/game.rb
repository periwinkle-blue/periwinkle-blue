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
    king = self.pieces.where(:type => 'King', :color => color).first

    # Pass current position of King to check
    find_king_obstruction(king.x_position, king.y_position, king.color)
  end

  def find_king_obstruction(x, y, color)
    # Check horizontals for opposite queen and rook
    #king_in_check_left?(x, y, color)
    #king_in_check_right?(x, y, color)
    #king_in_check_top?(x, y, color)
    king_in_check_bottom?(x, y, color)

  end

  def king_in_check_left?(x, y, color)
    # Check king left horizontal position until 0 or obstructed for queen or rook
    left = piece_on(x, (y - 1))

    while y >= 0
      # Geesh nils!
      # No piece at position before last column
      if left.nil? && y > 0
        y -= 1
        # Update y position
        left = piece_on(x, y)
        next
      # No piece at position at last column
      elsif left.nil? && y == 0
        # King is not in check
        return false
      # Opposite queen is next piece found
      elsif left.type == "Queen" && left.color != color
        # King is in check
        return true
      # Opposite rook is next piece found
      elsif left.type == "Rook" && left.color != color
        # King is in check
        return true
      else
        # Everything else found to the left of the king
        # King is not in check
        return false
      end
      y -= 1
    end

  end

  def king_in_check_right?(x, y, color)
    # Check king right horizontal position until 7 or obstructed for queen or rook
    right = piece_on(x, (y + 1))

    while y <= 7
      # Geesh nils!
      if right.nil? && y < 7
        y += 1
        # Update y position
        right = piece_on(x, y)
        next
      elsif right.nil? && y == 7
        return false
      elsif right.type == "Queen" && right.color != color
        return true
      elsif right.type == "Rook" && right.color != color
        return true
      else
        return false
      end
      y += 1
    end

  end

  def king_in_check_top?(x, y, color)
    # Check king top position until 0 or obstructed for queen or rook
    top = piece_on((x - 1), y)

    while x >= 0
      # Geesh nils!
      if top.nil? && x > 0
        x -= 1
        # Update x position
        top = piece_on(x, y)
        next
      elsif top.nil? && x == 0
        return false
      elsif top.type == "Queen" && top.color != color
        return true
      elsif top.type == "Rook" && top.color != color
        return true
      else
        return false
      end
      x -= 1
    end

  end

  def king_in_check_bottom?(x, y, color)
    # Check king bottom position until 7 or obstructed for queen or rook
    top = piece_on((x + 1), y)

    while x <= 7
      # Geesh nils!
      if top.nil? && x < 7
        x += 1
        # Update x position
        top = piece_on(x, y)
        next
      elsif top.nil? && x == 7
        return false
      elsif top.type == "Queen" && top.color != color
        return true
      elsif top.type == "Rook" && top.color != color
        return true
      else
        return false
      end
      x += 1
    end

  end

end
