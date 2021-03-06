class PiecesController < ApplicationController
  #before_action :is_current_user_turn, :only => [:update]
  #before_action :does_piece_belong_to_current_user, :only => [:update]
  
 

	def update	
    base_uri = 'https://incandescent-torch-3468.firebaseio.com/'

    firebase = Firebase::Client.new(base_uri)

    if !is_current_user_turn
      status = "invalid_move"
    else
		  status = current_piece.move_to(params[:piece][:x_position], params[:piece][:y_position])
    end

    if status == "own_piece"
    	render :json => { status: "own_piece", msg: "Can't take your own piece!" }
    elsif status == "invalid_move"
    	render :json => { status: "invalid_move", msg: "That move is invalid" }
    else   
     firebase.push("/games/",{:game=> current_game.id.to_s, :x_position => current_piece.x_position, :y_position => current_piece.y_position, :time => Time.now.to_i})   
     current_game.update_turn     
     render :json => { status: "success" } and return  
#		render :text => 'Success'
		end
	end

	private

	def current_piece
		@current_piece = Piece.find(params[:piece_id])
	end
  
  def current_game
    @game ||= Game.find_by_id(params[:game_id])
  end

	def piece_params
		params.require(:piece).permit(:x_position, :y_position)
	end
  
  # Authorize if the proper user is moving the piece
  def is_current_user_turn
    if current_game.turn != current_user.id
#      flash[:alert] = "Please wait for your turn!"
      #render :json => { status: "error", msg: "Please wait for your turn!"  } and 
      return false
    else
      return true
    end
  end
    
  def does_piece_belong_to_current_user
    is_your_piece = (current_piece.color == 1) ? 
      current_user.id == current_game.black_player_id : 
      current_user.id == current_game.white_player_id
    
    unless is_your_piece
#      flash[:alert] = "You cannot move your opponent's piece!"
      render :json => { status: "error", msg: "You cannot move your opponent's piece!" } and return
    end
    
  end

end
