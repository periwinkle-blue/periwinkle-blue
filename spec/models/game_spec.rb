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

  describe "#will_cause_check?" do

    context "with a non-threatening rook" do
      it "returns false" do
      end
    end

    context "with a rook of the same color" do
      it "returns false" do
      end
    end

    context "with a threatening pawn" do
      it "returns true" do
      end
    end

    context "with a threatening bishop" do
      it "returns true" do
      end
    end

    context "with a threatening knight" do
      it "returns true" do
      end
    end

    context "with a threatening queen" do
      it "returns true" do
      end
    end

    context "with a threatening king" do
      it "returns true" do
      end
    end


  end

  it "should loop through pieces and see if the king is in check" do
    King.create(:color => 0, :x_position => 3, :y_position => 3, :game => @game)
    # Bishop.create(:color => 1, :x_position => 3, :y_position => 3, :game => @game)
    # Queen.create(:color => 1, :x_position => 0, :y_position => 3, :game => @game)
    # Rook.create(:color => 1, :x_position => 0, :y_position => 3, :game => @game)
    # Pawn.create(:color => 1, :x_position => 2, :y_position => 4, :game => @game)
    Knight.create(:color => 1, :x_position => 1, :y_position => 4, :game => @game)
    Pawn.create(:color => 1, :x_position => 3, :y_position => 4, :game => @game)

    expect(@game.king_in_check?).to eq(true)
  end  


end
