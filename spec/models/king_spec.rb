require 'rails_helper'
require 'king'

RSpec.describe King, type: :model do

  before do
    # Create test data example
    @king = King.create(:x_position => 3, :y_position => 3)
  end

  it "should know the current x and y position" do
    expect(@king.x_position).to eq(3)
    expect(@king.y_position).to eq(3)
  end

  it "should know if the king top move is less than 2" do
    # Example top move
    top_x = 2
    top_y = 3

    # Calculate old move and new move
    top_x = (@king.x_position - top_x).abs # => 1
    top_y = (@king.y_position - top_y).abs # => 0

    expect(top_x).to be < 2
    expect(top_y).to be < 2
  end

  it "should know if the king bottom move is less than 2" do
    # Example bottom move
    bottom_x = 4
    bottom_y = 3

    # Calculate old move and new move
    bottom_x = (@king.x_position - bottom_x).abs # => 1
    bottom_y = (@king.y_position - bottom_y).abs # => 0

    expect(bottom_x).to be < 2
    expect(bottom_y).to be < 2
  end

  it "should know if the king left move is less than 2" do
    # Example left move
    left_x = 3
    left_y = 2

    # Calculate old move and new move
    left_x = (@king.x_position - left_x).abs # => 0
    left_y = (@king.y_position - left_y).abs # => 1

    expect(left_x).to be < 2
    expect(left_y).to be < 2
  end

  it "should know if the king right move is less than 2" do
    # Example right move
    right_x = 3
    right_y = 4

    # Calculate old move and new move
    right_x = (@king.x_position - right_x).abs # => 0
    right_y = (@king.y_position - right_y).abs # => 1

    expect(right_x).to be < 2
    expect(right_y).to be < 2
  end
  
end
