require 'rails_helper'

RSpec.describe Queen, type: :model do
  
  before do
    @game = Game.create
    @game.clear_board!
    
    @queen = Queen.create( :color => 0, :x_position => 3, :y_position => 4, :game => @game)
  end
  
  it "should allow a diagonal move" do
    expect(@queen.valid_move?(1,6)).to eq(true)
    expect(@queen.valid_move?(1,2)).to eq(true)
    expect(@queen.valid_move?(5,2)).to eq(true)
    expect(@queen.valid_move?(5,6)).to eq(true)
  end
  
  it "should allow a vertical move" do
    expect(@queen.valid_move?(0,4)).to eq(true)
    expect(@queen.valid_move?(6,4)).to eq(true)
  end
  
  it "should allow a horizontal move" do
    expect(@queen.valid_move?(3,1)).to eq(true)
    expect(@queen.valid_move?(3,6)).to eq(true)
  end
  
  it "should not allow a move that is not diagonal, horizontal, or vertical" do
    expect(@queen.valid_move?(2,6)).to eq(false)
    expect(@queen.valid_move?(1,5)).to eq(false)
    expect(@queen.valid_move?(4,2)).to eq(false)
    expect(@queen.valid_move?(0,0)).to eq(false)
  end
  
  it "should not allow a move that is off the board" do
    expect(@queen.valid_move?(3,8)).to eq(false)
    expect(@queen.valid_move?(-1,0)).to eq(false)
  end
  
  it "should not allow a move if target is obstructed" do
    expect(@queen.valid_move?(7,4)).to eq(true)
    @pawn = Pawn.create(:color => 0, :x_position => 5, :y_position => 4, :game => @game)
    expect(@queen.valid_move?(7,4)).to eq(false)
  end
  
end