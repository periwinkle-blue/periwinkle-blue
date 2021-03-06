require 'rails_helper'
require 'piece'

RSpec.describe Game, type: :model do

  include FactoryGirl::Syntax::Methods

  before do
    @white_player = create(:user)
    @black_player = create(:user)
    @game = Game.create( :white_player => @white_player, :black_player => @black_player, :turn => @white_player.id )
    @game.clear_board!
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

  it "should loop through pieces and see if the king is in check" do
    King.create(:color => 0, :x_position => 3, :y_position => 3, :game => @game)
    King.create(:color => 1, :x_position => 7, :y_position => 7, :game => @game)
    # Bishop.create(:color => 1, :x_position => 3, :y_position => 3, :game => @game)
    # Queen.create(:color => 1, :x_position => 0, :y_position => 3, :game => @game)
    Rook.create(:color => 1, :x_position => 0, :y_position => 3, :game => @game)
    # Pawn.create(:color => 1, :x_position => 2, :y_position => 4, :game => @game)
    # Knight.create(:color => 1, :x_position => 1, :y_position => 4, :game => @game)
    # Pawn.create(:color => 1, :x_position => 3, :y_position => 4, :game => @game)

    expect(@game.king_in_check).to eq("white_in_check")
  end

  it "should see if the king is in checkmate" do
    King.create(:color => 0, :x_position => 3, :y_position => 3, :game => @game)
    Queen.create(:color => 1, :x_position => 3, :y_position => 1, :game => @game)
    Rook.create(:color => 1, :x_position => 2, :y_position => 1, :game => @game)
    Rook.create(:color => 1, :x_position => 4, :y_position => 1, :game => @game)

    Bishop.create(:color => 1, :x_position => 5, :y_position => 6, :game => @game)

    expect(@game.king_in_check).to eq("white_checkmate")
  end

end
