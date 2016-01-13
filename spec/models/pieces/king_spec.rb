require 'rails_helper'
require 'king'

RSpec.describe King, type: :model do

  before do
    # Create test data example
    @game = Game.create
    @game.clear_board!
    
    @king = King.create(:x_position => 6, :y_position => 3, :game => @game, :color => 1)
  end

  it "it should only allow one move" do
    expect(@king.valid_move?(3, 2)).to eq(true)
    expect(@king.valid_move?(3, 4)).to eq(true)
    expect(@king.valid_move?(2, 3)).to eq(true)
    expect(@king.valid_move?(4, 3)).to eq(true)
  end
  
  describe "#will_cause_check?" do
    context "with a threatening rook" do
      it "returns true" do
        expect(@king.will_cause_check?(6, 4)).to eq(false)
        @rook = @game.pieces.create( :type => "Rook", :x_position => 2, :y_position => 4, :color => 0)
        expect(@king.will_cause_check?(6, 4)).to eq(true)
      end
    end
    
    context "with a non-threatening rook" do
      it "returns false" do
        @rook = @game.pieces.create( :type => "Rook", :x_position => 2, :y_position => 4, :color => 1)
        expect(@king.will_cause_check?(6, 4)).to eq(false)
      end
    end
    
    context "with a threatening bishop" do
      it "returns true" do
        expect(@king.will_cause_check?(6, 4)).to eq(false)
        @bishop = @game.pieces.create( :type => "Bishop", :x_position => 7, :y_position => 5, :color => 0)
        expect(@king.will_cause_check?(6, 4)).to eq(true)
      end      
    end
    
    context "with a non-threatening bishop" do
      it "returns false" do
        @bishop = @game.pieces.create( :type => "Bishop", :x_position => 4, :y_position => 5, :color => 0)
        expect(@king.will_cause_check?(6, 4)).to eq(false)
      end      
    end
    
    context "with a threatening knight" do
      it "returns true" do
        expect(@king.will_cause_check?(6, 4)).to eq(false)
        @knight = @game.pieces.create( :type => "Knight", :x_position => 5, :y_position => 6, :color => 0)
        expect(@king.will_cause_check?(6, 4)).to eq(true)
      end      
    end
    
    context "with a non-threatening knight" do
      it "returns false" do
        @knight = @game.pieces.create( :type => "Knight", :x_position => 0, :y_position => 2, :color => 0)
        expect(@king.will_cause_check?(6, 4)).to eq(false)
      end      
    end
    
    context "with a threatening queen" do
      it "returns true" do
        expect(@king.will_cause_check?(7, 3)).to eq(false)
        @queen = @game.pieces.create( :type => "Queen", :x_position => 7, :y_position => 0, :color => 0)
        expect(@king.will_cause_check?(7, 3)).to eq(true)
      end      
    end
    
    context "with a non-threatening queen" do
      it "returns false" do
        @queen = @game.pieces.create( :type => "Queen", :x_position => 7, :y_position => 0, :color => 0)
        expect(@king.will_cause_check?(1, 3)).to eq(false)
      end      
    end
    
    context "with a threatening king" do
      it "returns true" do
        expect(@king.will_cause_check?(5, 3)).to eq(false)
        @king = @game.pieces.create( :type => "King", :x_position => 4, :y_position => 3, :color => 0)
        expect(@king.will_cause_check?(5, 3)).to eq(true)
      end      
    end
    
    context "with a non-threatening king" do
      it "returns true" do
        @king = @game.pieces.create( :type => "King", :x_position => 3, :y_position => 5, :color => 0)
        expect(@king.will_cause_check?(5, 3)).to eq(false)
      end      
    end
    
    context "with a threatening pawn" do
      it "returns true" do
        expect(@king.will_cause_check?(5, 3)).to eq(false)
        @king = @game.pieces.create( :type => "King", :x_position => 4, :y_position => 3, :color => 0)
        expect(@king.will_cause_check?(5, 3)).to eq(true)
      end      
    end
    
    context "with a non-threatening pawn" do
      it "returns true" do
        @king = @game.pieces.create( :type => "King", :x_position => 3, :y_position => 5, :color => 0)
        expect(@king.will_cause_check?(5, 3)).to eq(false)
      end      
    end
    
    context "with piece of the same color" do
      it "returns false" do
        @rook = @game.pieces.create( :type => "Rook", :x_position => 2, :y_position => 4, :color => 1)
        expect(@king.will_cause_check?(6, 4)).to eq(false)
      end
    end
    
  end

end
