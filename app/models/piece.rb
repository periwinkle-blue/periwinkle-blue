class Piece < ActiveRecord::Base
	belongs_to :game
  belongs_to :user

	def is_obstructed?(x,y)
		#determine direction that needs to be checked
		if x_position == x
			return is_obstructed_horizontally?(x,y)
		elsif y_position == y
			return is_obstructed_vertically?(x,y)
		elsif ((x_position - x) / (y_position - y)) == 1 or -1
			return is_obstructed_diagonally?(x,y)
		else
			return false
		end
	end

	def move_to(x,y)
	  target_piece = game.pieces.where(:x_position => x.to_i, :y_position => y.to_i).first
	  if !valid_move?(x.to_i, y.to_i)
	  	return "invalid_move"
	  elsif target_piece !=nil and target_piece.color != self.color and valid_move?(x.to_i, y.to_i)
	  	target_piece.destroy
	    update_attributes(:x_position => x.to_i, :y_position => y.to_i, :moved => true) 
	    return "success"
	  else
	  	update_attributes(:x_position => x.to_i, :y_position => y.to_i, :moved => true)
	  	return "success"
	  end   
	end


  def valid_move?(x, y)
    # Valid parameters passed in?      
    return false if params_out_of_bounds?(x, y) or taking_own_piece?(x,y)
    #return false if params_out_of_bounds?(x, y) or occupied_by_teammate?(x, y)
    return true
  end

	private


  	def taking_own_piece?(x, y)
  		target_piece = game.pieces.where(:x_position => x.to_i, :y_position => y.to_i).first
  		if target_piece.nil?
  			return false
  		elsif target_piece.color == self.color
  			return true
  		else
  			return false
  		end
  	end

	  def params_out_of_bounds?(x, y)
	    return true if x < 0 || y < 0 || x > 7 || y > 7
	  end



    def is_valid_diagonal_move?(x, y)
      x_diff = (self.x_position - x).abs
      y_diff = (self.y_position - y).abs

      x_diff == y_diff# and !self.is_obstructed?(x,y)  
    end

    def is_valid_horizontal_or_vertical_move?(x, y)
      (self.x_position == x or self.y_position == y)# and !self.is_obstructed?(x,y)
    end

    def params_out_of_bounds?(x, y)
      return true if x < 0 || y < 0 || x > 7 || y > 7
    end
  
    def occupied_by_teammate?(x, y)
      piece = self.game.piece_on(x, y)

      return true if !piece.nil? and piece.color == self.color      
    end


	def is_obstructed_diagonally?(x,y)
		range = (y_position - y).abs - 1
		if x_position > x
			x_new = x
			y_new = y
		elsif x_position < x
			x_new = x_position
			y_new = y_position
		end

		if (y_position > y and x_position > x) or (y_position < y and x_position < x)
			(1..range).each do |offset|
				x_new += 1
				y_new += 1
				return true if game.pieces.where(x_position: x_new, y_position: y_new).present?
			end
		elsif (y_position < y and x_position > x) or (y_position > y and x_position < x)
			(1..range).each do |offset|
				x_new += 1
				y_new -= 1
				return true if game.pieces.where(x_position: x_new, y_position: y_new).present?
			end
		end

		return false
	end

	def is_obstructed_vertically?(x,y)
		range = (x_position - x).abs - 1
		if x_position > x
			x_new = x
		elsif x_position < x
			x_new = x_position
		end
		(1..range).each do |offset|
			x_new += 1
			return true if game.pieces.where(x_position: x_new, y_position: y).present?
		end
		return false
	end

	def is_obstructed_horizontally?(x,y)
		range = (y_position - y).abs - 1
		if y_position > y
			y_new = y
		elsif y_position < y
			y_new = y_position
		end
		(1..range).each do |offset|
			y_new += 1
			return true if game.pieces.where(x_position: x, y_position: y_new).present?
		end
		return false
	end

end
