require 'rails_helper'
require 'king'

RSpec.describe King, type: :model do

  before do
    # Create test data example
    @king = King.create(:x_position => 7, :y_position => 4)
  end

  it "should know the current x and y position" do
    expect(@king.x_position).to eq(7)
    expect(@king.y_position).to eq(4)
  end

  it "should know if the king move is equal to 1" do
    # Example new move
    new_x = 8
    new_y = 3

    # Calculate old move and new move
    x_move = (@king.x_position - new_x).abs
    y_move = (@king.y_position - new_y).abs

    expect(x_move).to eq(1)
    expect(y_move).to eq(1)
  end

end
