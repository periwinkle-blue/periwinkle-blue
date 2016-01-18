require 'rails_helper'
require 'piece'

RSpec.describe Game, type: :model do

  before do
    @game = Game.create
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


end
