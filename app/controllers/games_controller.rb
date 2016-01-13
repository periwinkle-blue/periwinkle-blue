class GamesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    Game.create( :white_player_id => current_user.id )
    flash[:notice] = "Your game has been created.  While you wait for an opponent, consider joining another open game."
    redirect_to games_path
  end

  def update
    @game = Game.find_by_id(params[:id])
    @game.update_attributes( :black_player_id => current_user.id )
    flash[:notice] = "You've joined the game!"
    redirect_to game_path(@game)
  end

	def index
    @games = Game.order(:id)
    @own_games_created = Game.where( white_player_id: current_user.id ).order(:id)
    #   current_user.id == game.white_player_id
    @own_games_joined = Game.where( black_player_id: current_user.id ).order(:id)
    #   current_user.id == game.black_player_id 
    # @open_games = 
    #   if (current_user.id != game.white_player_id) && game.black_player_id.nil?
	end

  def show
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
  end

end
