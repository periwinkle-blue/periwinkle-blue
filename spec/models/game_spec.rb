require 'rails_helper'
require 'piece'

RSpec.describe Game, type: :model do

  before do
    @game = Game.create
    @game.clear_board!

    @king = @game.pieces.create( :x_position => 6, :y_position => 3, :color => 1)
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


  # Left this in case needed
  it "should loop through and check for pieces" do
    Knight.create(:color => 0, :x_position => 0, :y_position => 0, :game => @game) # &#9816;
    Pawn.create(:color => 0, :x_position => 1, :y_position => 3, :game => @game) # &#9817;
    Queen.create(:color => 0, :x_position => 2, :y_position => 5, :game => @game) # &#9813;
    King.create(:color => 1, :x_position => 4, :y_position => 3, :game => @game) # &#9818;
    Bishop.create(:color => 1, :x_position => 6, :y_position => 5, :game => @game) # &#9821;
    Rook.create(:color => 1, :x_position => 7, :y_position => 7, :game => @game) # &#9820;

    for x in 0..7
      for y in 0..7
        expect(@game.find_piece_icon(x, y)).to eq("&#9816;") if x == 0 && y == 0
        expect(@game.find_piece_icon(x, y)).to eq("") if x == 0 && y == 2
        expect(@game.find_piece_icon(x, y)).to eq("&#9817;") if x == 1 && y == 3
        expect(@game.find_piece_icon(x, y)).to eq("&#9813;") if x == 2 && y == 5
        expect(@game.find_piece_icon(x, y)).to eq("&#9818;") if x == 4 && y == 3
        expect(@game.find_piece_icon(x, y)).to eq("&#9821;") if x == 6 && y == 5
        expect(@game.find_piece_icon(x, y)).to eq("&#9820;") if x == 7 && y == 7
      end
    end
  end

  it "should check horizontal pieces king" do
    King.create(:color => 0, :x_position => 2, :y_position => 2, :game => @game)
    #pawn = Pawn.create(:color => 0, :x_position => 1, :y_position => 0, :game => @game)
    Rook.create(:color => 1, :x_position => 2, :y_position => 0, :game => @game)

    expect(@game.king_in_check?).to eq(true)
  end

  it "should check vertical pieces king" do
    King.create(:color => 0, :x_position => 7, :y_position => 0, :game => @game)
    #pawn = Pawn.create(:color => 0, :x_position => 1, :y_position => 0, :game => @game)
    Rook.create(:color => 1, :x_position => 2, :y_position => 0, :game => @game)

    expect(@game.king_in_check?).to eq(true)
  end

  it "should check top left diagonal pieces for king" do
    King.create(:color => 0, :x_position => 2, :y_position => 2, :game => @game)
    #pawn = Pawn.create(:color => 0, :x_position => 1, :y_position => 0, :game => @game)
    Bishop.create(:color => 1, :x_position => 4, :y_position => 4, :game => @game)

    expect(@game.king_in_check?).to eq(true)
  end
=begin
  it "should check top right diagonal pieces for king" do
    King.create(:color => 0, :x_position => 2, :y_position => 2, :game => @game)
    #pawn = Pawn.create(:color => 0, :x_position => 1, :y_position => 0, :game => @game)
    Bishop.create(:color => 1, :x_position => 4, :y_position => 4, :game => @game)

    expect(@game.king_in_check?).to eq(true)
  end

  it "should check bottom left diagonal pieces for king" do
    King.create(:color => 0, :x_position => 2, :y_position => 2, :game => @game)
    #pawn = Pawn.create(:color => 0, :x_position => 1, :y_position => 0, :game => @game)
    Bishop.create(:color => 1, :x_position => 4, :y_position => 4, :game => @game)

    expect(@game.king_in_check?).to eq(true)
  end

  it "should check bottom right diagonal pieces for king" do
    King.create(:color => 0, :x_position => 2, :y_position => 2, :game => @game)
    #pawn = Pawn.create(:color => 0, :x_position => 1, :y_position => 0, :game => @game)
    Bishop.create(:color => 1, :x_position => 4, :y_position => 4, :game => @game)

    expect(@game.king_in_check?).to eq(true)
  end
=end






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
