require 'rails_helper'

RSpec.describe Piece, type: :model do
  
  before do
    @game = Game.create
    @game.clear_board_pieces
    @piece = @game.pieces.create( :x_position => 3, :y_position => 4)

  end
  
  it "should return correct x,y coordinates for given piece" do
    expect(@piece.x_position).to eq(3)
    expect(@piece.y_position).to eq(4)
  end
  
  it "should see no obstructions between two horizontal pieces" do
    #@target_piece = Piece.create( :x_position => 3, :y_position => 7, :game => @game)
    @target_piece = @game.pieces.create( :x_position => 3, :y_position => 7)
    @random_piece1 = @game.pieces.create( :x_position => 6, :y_position => 0)
    @random_piece2 = @game.pieces.create( :x_position => 2, :y_position => 6)
    
    is_obstructed = @piece.is_obstructed?(@target_piece.x_position, @target_piece.y_position)
    expect(is_obstructed).to eq(false)
  end
  
  it "should see no obstructions between two vertical pieces" do
    @target_piece = @game.pieces.create( :x_position => 0, :y_position => 4)
    @random_piece1 = @game.pieces.create( :x_position => 7, :y_position => 4)
    @random_piece2 = @game.pieces.create( :x_position => 3, :y_position => 6)
    
    is_obstructed = @piece.is_obstructed?(@target_piece.x_position, @target_piece.y_position)
    expect(is_obstructed).to eq(false)
  end
  
  it "should see no obstructions between two diagonal pieces" do
    @target_piece = @game.pieces.create( :x_position => 0, :y_position => 1)
    @random_piece1 = @game.pieces.create( :x_position => 2, :y_position => 5)
    @random_piece2 = @game.pieces.create( :x_position => 6, :y_position => 7)
    
    is_obstructed = @piece.is_obstructed?(@target_piece.x_position, @target_piece.y_position)
    expect(is_obstructed).to eq(false)
  end
  
  it "should see one obstruction between two vertical pieces" do
    @target_piece = @game.pieces.create( :x_position => 7, :y_position => 4)
    @obstructing_piece = @game.pieces.create( :x_position => 5, :y_position => 4)
    
    is_obstructed = @piece.is_obstructed?(@target_piece.x_position, @target_piece.y_position)
    expect(is_obstructed).to eq(true)
  end
  
  it "should see one obstruction between two horizontal pieces" do
    @target_piece = @game.pieces.create( :x_position => 3, :y_position => 0)
    @obstructing_piece = @game.pieces.create( :x_position => 3, :y_position => 2)
    
    is_obstructed = @piece.is_obstructed?(@target_piece.x_position, @target_piece.y_position)
    expect(is_obstructed).to eq(true)
  end
  
  it "should see one obstruction between two diagonal pieces" do
    @target_piece = @game.pieces.create( :x_position => 6, :y_position => 7)
    @obstructing_piece = @game.pieces.create( :x_position => 5, :y_position => 6)
    
    is_obstructed = @piece.is_obstructed?(@target_piece.x_position, @target_piece.y_position)
    expect(is_obstructed).to eq(true)
  end
  
  it "should display the right icon unicode for a white and black bishop" do
    bishop = Bishop.create( :color => 1, :x_position => 3, :y_position => 4, :game => @game)
    expect(bishop.icon).to eq("&#9821;")
    
    bishop = Bishop.create( :color => 0, :x_position => 2, :y_position => 2, :game => @game)
    expect(bishop.icon).to eq("&#9815;")
  end
  
  it "should display the right icon unicode for a white and black king" do
    king = King.create( :color => 1, :x_position => 3, :y_position => 4, :game => @game)
    expect(king.icon).to eq("&#9818;")

    king = King.create( :color => 0, :x_position => 1, :y_position => 0, :game => @game)
    expect(king.icon).to eq("&#9812;")
  end
  
end
