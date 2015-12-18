class GamesController < ApplicationController

	def index

	end

	def show
      @game = Game.find_by_id(params[:game_id])
      @selected_piece = @game.pieces.find_by_id(params[:piece_id])
      @board = [
                  [1, 0, 1, 0, 1, 0, 1, 0],
                  [0, 1, 0, 1, 0, 1, 0, 1],
                  [1, 0, 1, 0, 1, 0, 1, 0],
                  [0, 1, 0, 1, 0, 1, 0, 1],
                  [1, 0, 1, 0, 1, 0, 1, 0],
                  [0, 1, 0, 1, 0, 1, 0, 1],
                  [1, 0, 1, 0, 1, 0, 1, 0],
                  [0, 1, 0, 1, 0, 1, 0, 1]
              ]
              
      if @selected_piece.present?
        @selected_piece.update_attributes(:x_position => params[:x], :y_position => params[:y])
      end 

      if @game.nil?
        render :text => "No game specified", :status => :not_found
      end


	end

  
end
