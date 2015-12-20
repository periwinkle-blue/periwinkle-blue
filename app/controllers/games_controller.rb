class GamesController < ApplicationController
	def index

	end

	def show
      @game = Game.find_by_id(params[:game_id])
      
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
      
      if @game.nil?
        render :text => "No game specified", :status => :not_found
      else
        @selected_piece = @game.pieces.find_by_id(params[:piece_id])
      end

      if @selected_piece.present? and params[:x].present?
        @target = @game.pieces.where(x_position: params[:x], y_position: params[:y]).first

        if @target.present? and @target.color != @selected_piece.color
          @target.delete
          @selected_piece.move_to(params[:x], params[:y])
        elsif @target.nil?
          @selected_piece.move_to(params[:x], params[:y])
        else
          flash[:error] = 'You cant take your own piece!'
        end
        
        redirect_to game_path(@game)
      end 

	end
  
end
