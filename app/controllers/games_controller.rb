class GamesController < ApplicationController
  before_action :authenticate_user!
  add_flash_types :game_alert

  def create
    status = Game.create( :white_player_id => current_user.id )
    flash[:notice] = "Your game has been created.  While you wait for an opponent, consider joining another open game."
    redirect_to games_path
  end

  def join
    @game = Game.find_by_id(params[:id])
    @game.update_attributes( :black_player_id => current_user.id, :turn => @game.white_player_id )
    flash[:notice] = "You've joined the game!"
    redirect_to game_path(@game)
  end

	def index
    @own_playable_games = Game.where.not( black_player_id: nil ).where( "white_player_id = ? OR black_player_id = ?", current_user.id, current_user.id ).order(:id)
    @own_open_games = Game.where( white_player_id: current_user.id ).where( black_player_id: nil ).order(:id)
    @open_games = Game.where.not( white_player_id: current_user.id ).where( black_player_id: nil ).order(:id)
	end

  def show
    puts "In Games#show"
      @game = Game.find_by_id(params[:id])

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
      end

      # Check to see if king is in check
      king_check = @game.king_in_check

      if king_check == "white_in_check"
        flash[:game_alert] = "White king in check!"
      elsif king_check == "white_checkmate"
        flash[:game_alert] = "Checkmate on white king!"
      elsif king_check == "black_in_check"
          flash[:game_alert] = "Black king in check!"
      elsif king_check == "black_checkmate"
          flash[:game_alert] = "Checkmate on black king!"
      else
        # Prevents King is in check notice from displaying once more after move
        flash[:game_alert] = ""
      end
  end

end
