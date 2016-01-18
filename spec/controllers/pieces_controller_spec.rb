require 'rails_helper'

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end

RSpec.describe PiecesController, type: :controller do
  include FactoryGirl::Syntax::Methods
  
  describe "#authorize user attempting move" do
    
    describe "player can only move their piece" do
      before do
        @white_player = create(:user)
        @black_player = create(:user)
        @game = create(:game, :white_player_id => @white_player.id, :black_player_id => @black_player.id, :turn => @white_player.id)
      end
      
      context "white player moves white piece" do
        it "allows move" do
          sign_in @white_player          
          white_piece = @game.piece_on(1, 0)
          
          put :update, :game_id => @game.id, :piece_id => white_piece.id, :piece => {
              :x_position => 3,
              :y_position => 0
          } 
          
          expect(response.status).to eq(200)
          #expect(response).to redirect_to(:controller => :pieces, :action => :update)
        end
      end

      context "white player moves black piece" do
        it "does not allow move" do
          sign_in @white_player          
          black_piece = @game.piece_on(6, 0)
          
          put :update, :game_id => @game.id, :piece_id => black_piece.id, :piece => {
              :x_position => 5,
              :y_position => 0
          } 
          
          expect(response).to redirect_to(game_path(@game))
          expect(flash[:alert]).to eq("You cannot move your opponent's piece!")
        end
      end
      
      context "black player moves black piece" do
        it "allows move" do
          sign_in @black_player
          black_piece = @game.piece_on(6, 0)
          
          #Update to black player's turn
          @game.turn = @black_player.id
          @game.save
          @game.reload

          put :update, :game_id => @game.id, :piece_id => black_piece.id, :piece => {
              :x_position => 5,
              :y_position => 0
          } 
          
          expect(response.status).to eq(200)
        end
      end

      context "black player moves white piece" do
        it "does not allow move" do
          sign_in @black_player      
          white_piece = @game.piece_on(1, 0)
          
          #Update to black player's turn
          @game.turn = @black_player.id
          @game.save
          @game.reload
          
          put :update, :game_id => @game.id, :piece_id => white_piece.id, :piece => {
              :x_position => 2,
              :y_position => 0
          } 
          
          expect(response).to redirect_to(game_path(@game))
          expect(flash[:alert]).to eq("You cannot move your opponent's piece!")
        end
      end

    end
    
    describe "player can only move during their turn" do
      context "white player moves white piece during white move" do
      
      end

      context "white player moves white piece during white move" do

      end

      context "white player moves white piece during white move" do

      end
    end
    
    
    
  end
  
end
