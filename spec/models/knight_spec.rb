require 'rails_helper'
require 'knight'

RSpec.describe Knight, type: :model do

  before do
    # Example of top move at 0, 0
    @knight1 = Knight.create(:x_position => 0, :y_position => 0)
    # Example of ability to use full move
    @knight = Knight.create(:x_position => 3, :y_position => 3)

    # Example of top move limted to 1
    @knight1 = Knight.create(:x_position => 1, :y_position => 0)

  end


=begin
  # Test for equals to 1
  it "should know if the knight top move is limited to 1 and left move is 0" do
    # Example top move
    top_x = 0
    top_left_y = 0 # or
    top_right_y = 2

    # Calculate old move and new move
    top_x = (@knight1.x_position - top_x).abs # => 1
    top_left_y = (@knight1.y_position - top_left_y).abs # => 0
    top_right_y = (@knight1.y_position - top_right_y).abs # => 2

    expect(top_x).to be == 1
    expect(top_left_y).to be == 0
    expect(top_right_y).to be == 2
  end

  # Test for the ability to use full move
  it "should know if the knight top move is equal to 2 and then left or right is equal to 1" do
      # Example top move
      top_x = 1
      top_left_y = 2 # or
      top_right_y = 4

      # Calculate old move and new move
      top_x = (@knight.x_position - top_x).abs # => 2
      top_left_y = (@knight.y_position - top_left_y).abs # => 1
      top_right_y = (@knight.y_position - top_right_y).abs # => 1

      expect(top_x).to be == 2
      expect(top_left_y).to be == 1
      expect(top_right_y).to be == 1
  end

  it "should know if the knight bottom move is equal to 2 and then left or right is equal to 1" do
      # Example bottom move
      bottom_x = 5
      bottom_left_y = 2 # or
      bottom_right_y = 4

      # Calculate old move and new move
      bottom_x = (@knight.x_position - bottom_x).abs # => 2
      bottom_left_y = (@knight.y_position - bottom_left_y).abs # => 1
      bottom_right_y = (@knight.y_position - bottom_right_y).abs # => 1

      expect(bottom_x).to be == 2
      expect(bottom_left_y).to be == 1
      expect(bottom_right_y).to be == 1
  end

  it "should know if the knight left move is equal to 2 and then top or bottom is equal to 1" do
      # Example left move
      left_y = 1
      left_top_x = 2 # or
      left_bottom_x = 4

      # Calculate old move and new move
      left_y = (@knight.x_position - left_y).abs # => 2
      left_top_x = (@knight.y_position - left_top_x).abs # => 1
      left_bottom_x = (@knight.y_position - left_bottom_x).abs # => 1

      expect(left_y).to be == 2
      expect(left_top_x).to be == 1
      expect(left_bottom_x).to be == 1
  end

  it "should know if the knight right move is equal to 2 and then top or bottom is equal to 1" do
      # Example bottom move
      right_y = 5
      right_top_x = 2 # or
      right_bottom_x = 4

      # Calculate old move and new move
      right_y = (@knight.x_position - right_y).abs # => 2
      right_top_x = (@knight.y_position - right_top_x).abs # => 1
      right_bottom_x = (@knight.y_position - right_bottom_x).abs # => 1

      expect(right_y).to be == 2
      expect(right_top_x).to be == 1
      expect(right_bottom_x).to be == 1
  end
=end
end
