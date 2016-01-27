require 'rails_helper'

RSpec.describe Pawn, type: :model do
  
  before do
    @game = Game.create
    @game.clear_board!
    @pawn = Pawn.create( :color => 1, :x_position => 3, :y_position => 4, :game => @game)
  end
  
  it "should allow one move forward" do
    expect(@pawn.valid_move?(2,4)).to eq(true)
  end
  
  it "should allow two moves forward on the first move" do
    expect(@pawn.valid_move?(1,4)).to eq(true)
  end
  
  it "should not allow two moves forward after the first move" do
    @pawn.move_to(2,4)
    expect(@pawn.valid_move?(0,4)).to eq(nil)
  end
  
  it "should not allow two moves forward is obstructed" do
    @piece = Piece.create(:color => 0, :x_position => 2, :y_position => 4, :game => @game)
    expect(@pawn.move_to(1,4)).to eq("invalid_move")
  end
  
  it "can move diagonally left when capturing a piece diagonal to it" do
    @piece = Piece.create(:color => 0, :x_position => 2, :y_position => 3, :game => @game)
    expect(@pawn.valid_move?(2,3)).to eq(true)
  end
  
  it "can move diagonally right when capturing a piece diagonal to it" do
    @piece = Piece.create(:color => 0, :x_position => 2, :y_position => 5, :game => @game)
    expect(@pawn.valid_move?(2,5)).to eq(true)
  end
    
  it "cannot move backward diagonally, horizontally, or vertically" do
    expect(@pawn.valid_move?(4,4)).to eq(nil)
    expect(@pawn.valid_move?(6,4)).to eq(nil)
    expect(@pawn.valid_move?(5,3)).to eq(nil)
    expect(@pawn.valid_move?(5,5)).to eq(nil)
  end
  
  it "should not allow a move that is off the board" do
    expect(@pawn.valid_move?(3,8)).to eq(false)
    expect(@pawn.valid_move?(-1,0)).to eq(false)
  end
  
end