class PiecesController < ApplicationController

	skip_before_action :verify_authenticity_token

	def update
		@game = Game.find_by_id(params[:game_id])
		current_piece.update_attributes(piece_params)
		render :text => 'Success'
		
	end

	private

	def current_piece
		@current_piece = Piece.find(params[:piece_id])
	end

	def piece_params
		params.require(:piece).permit(:x_position, :y_position)
	end

end
