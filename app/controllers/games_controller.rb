class GamesController < ApplicationController
  before_action :authenticate_user!

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
    @own_games_created = Game.where( white_player_id: current_user.id ).order(:id)
    @own_games_joined = Game.where( black_player_id: current_user.id ).order(:id)
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
      king_check = @game.king_in_check?

      if king_check
        flash[:notice] = "King is in check!"
      else
        # Prevents King is in check notice from displaying once more after move
        flash[:notice] = ""
      end
  end

end
