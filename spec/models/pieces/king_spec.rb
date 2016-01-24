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
    expect(@king.valid_move?(6, 2)).to eq(true)
    expect(@king.valid_move?(5, 4)).to eq(true)
    expect(@king.valid_move?(7, 3)).to eq(true)
    expect(@king.valid_move?(7, 4)).to eq(true)
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
        @opposing_king = @game.pieces.create( :type => "King", :x_position => 4, :y_position => 3, :color => 0)
        expect(@king.will_cause_check?(5, 3)).to eq(true)
      end      
    end
    
    context "with a non-threatening king" do
      it "returns true" do
        @opposing_king = @game.pieces.create( :type => "King", :x_position => 3, :y_position => 5, :color => 0)
        expect(@king.will_cause_check?(5, 3)).to eq(false)
      end      
    end
    
    context "with a threatening white pawn on black king" do
      it "returns true" do
        expect(@king.will_cause_check?(5, 3)).to eq(false)
        @pawn = @game.pieces.create( :type => "Pawn", :x_position => 4, :y_position => 2, :color => 0)
        expect(@king.will_cause_check?(5, 3)).to eq(true)
      end      
    end
    
    context "with a non-threatening white pawn on black king" do
      it "returns false" do
        expect(@king.will_cause_check?(5, 3)).to eq(false)
        @pawn = @game.pieces.create( :type => "Pawn", :x_position => 6, :y_position => 2, :color => 0)
        expect(@king.will_cause_check?(5, 3)).to eq(false)
      end      
    end
    
    context "with a threatening black pawn on white king" do
      it "returns true" do
        @white_king = @game.pieces.create( :type => "King", :x_position => 2, :y_position => 5, :color => 0)
        expect(@white_king.will_cause_check?(2, 4)).to eq(false)
        @pawn = @game.pieces.create( :type => "Pawn", :x_position => 3, :y_position => 3, :color => 1)
        expect(@white_king.will_cause_check?(2, 4)).to eq(true)
      end      
    end
    
    context "with a non-threatening black pawn on white king" do
      it "returns false" do
        @white_king = @game.pieces.create( :type => "King", :x_position => 2, :y_position => 5, :color => 0)
        expect(@white_king.will_cause_check?(2, 4)).to eq(false)
        @pawn = @game.pieces.create( :type => "Pawn", :x_position => 1, :y_position => 3, :color => 1)
        expect(@white_king.will_cause_check?(2, 4)).to eq(false)
      end      
    end
    
    context "with a non-threatening pawn" do
      it "returns true" do
        @pawn = @game.pieces.create( :type => "Pawn", :x_position => 3, :y_position => 5, :color => 0)
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
  
  describe "#in_checkmate?" do
    
    context "threatended by opposing pieces" do
      describe "opposing queen" do
        it "returns true" do
          @king.x_position = 0
          @king.y_position = 1
          @king.save

          @pawn1 = Pawn.create( :x_position => 1, :y_position => 0, :game => @game, :color => 1)
          @pawn2 = Pawn.create( :x_position => 1, :y_position => 1, :game => @game, :color => 1)
          @pawn3 = Pawn.create( :x_position => 1, :y_position => 2, :game => @game, :color => 1)
          @white_queen = Queen.create( :x_position => 0, :y_position => 4, :game => @game, :color => 0)

          @game.reload

          expect(@king.in_checkmate?).to eq(true)
        end
      end
      
      describe "opposing rooks" do 
        it "returns true" do
          @king.x_position = 0
          @king.y_position = 7
          @king.save

          @white_rook1 = Rook.create( :x_position => 1, :y_position => 1, :game => @game, :color => 0)
          @white_rook2 = Rook.create( :x_position => 0, :y_position => 0, :game => @game, :color => 0)

          @game.reload

          expect(@king.in_checkmate?).to eq(true)
        end
      end
    end
    
    context "not in checkmate after move" do
      it "returns false" do
        @pawn = Pawn.create( :x_position => 7, :y_position => 2, :game => @game, :color => 0 )
        @pawn = Pawn.create( :x_position => 6, :y_position => 4, :game => @game, :color => 0 )
        
        @game.reload
        
        expect(@king.in_checkmate?).to eq(false)
      end
    end
    
  end
  
  describe "#in_stalemate" do
    it "returns true" do
      @king.x_position = 4
      @king.y_position = 0
      @king.save
      
      @white_king = King.create( :x_position => 4, :y_position => 2, :game => @game, :color => 0 )
      @white_queen = Queen.create( :x_position => 3, :y_position => 3, :game => @game, :color => 0 )
      @white_knight = Knight.create( :x_position => 7, :y_position => 1, :game => @game, :color => 0 )
      
      @game.reload
      
      expect(@king.in_stalemate?).to eq(true)
      
    end
  end

end
