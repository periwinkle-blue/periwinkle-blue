require 'rails_helper'
require 'piece'

RSpec.describe Game, type: :model do
  include FactoryGirl::Syntax::Methods
  
  before do
    @white_player = create(:user)
    @black_player = create(:user)
    @game = Game.create( :white_player => @white_player, :black_player => @black_player, :turn => @white_player.id )
    @game.clear_board!
    
    @king = @game.pieces.create( :type => "King", :x_position => 6, :y_position => 3, :color => 1)
  end
  
  it "should find matching piece in the game" do
    bishop = Bishop.create(:x_position => 0, :y_position => 4, :color => 1, :game => @game)
    
    piece = @game.find_piece_icon(0, 4)
    expect(piece).not_to eq("")
  end
  
  it "shouldn't find matching piece in the game" do
    bishop = Bishop.create(:x_position => 0, :y_position => 4, :color => 1, :game => @game)
    
    piece = @game.find_piece_icon(0, 3)
    expect(piece).to eq("")
  end
  
  describe "#get_current_turn_message" do
    
    context "white player's turn with white player passed in" do
      it "returns 'Your turn'" do
        message = @game.get_current_turn_message(@white_player.id)
        expect(message).to eq("Your turn!")
      end
    end
    
    context "white player's turn with black player passed in" do
      it "returns 'Waiting on other user'" do
        message = @game.get_current_turn_message(@black_player.id)
        expect(message).to eq("Waiting on #{@white_player.email}")
      end
    end
        
  end
  
#  describe "#player_in_checkmate" do
#    
#    context "threatended by opposing pieces" do
#      describe "opposing queen" do
#        it "returns true" do
#          @king.x_position = 0
#          @king.y_position = 1
#          @king.save
#
#          @pawn1 = Pawn.create( :x_position => 1, :y_position => 0, :game => @game, :color => 1)
#          @pawn2 = Pawn.create( :x_position => 1, :y_position => 1, :game => @game, :color => 1)
#          @pawn3 = Pawn.create( :x_position => 1, :y_position => 2, :game => @game, :color => 1)
#          @white_queen = Queen.create( :x_position => 0, :y_position => 4, :game => @game, :color => 0)
#
#          @game.reload
#
#          expect(@game.in_checkmate?(@black_player.id)).to eq(true)
#        end
#      end
#      
#      describe "opposing rooks" do 
#        it "returns true" do
#          @king.x_position = 0
#          @king.y_position = 7
#          @king.save
#
#          @white_rook1 = Rook.create( :x_position => 1, :y_position => 1, :game => @game, :color => 0)
#          @white_rook2 = Rook.create( :x_position => 0, :y_position => 0, :game => @game, :color => 0)
#
#          @game.reload
#
#          expect(@game.in_checkmate?(@black_player.id)).to eq(true)
#        end
#      end
#    end
#    
#    context "not in checkmate after move" do
#      it "returns false" do
#      end
#    end
    
#  end
  
end
