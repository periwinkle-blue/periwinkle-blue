class PiecesController < ApplicationController

	def update		
		current_piece.move_to(params[:x_position], params[:y_position])
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
