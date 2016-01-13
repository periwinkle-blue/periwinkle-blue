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
  
  describe "#will_cause_check?" do
    context "with a threatening rook" do
      it "returns true" do
        expects(@king.will_cause_check?(6, 4)).to eq(false)
        @rook = @game.pieces.create( :type => "Rook", :x_position => 2, :y_position => 4, :color => 0)
        expects(@king.will_cause_check?(6, 4)).to eq(true)
      end
    end
    
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
