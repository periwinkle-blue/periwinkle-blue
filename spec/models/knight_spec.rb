require 'rails_helper'
require 'knight'

RSpec.describe Knight, type: :model do

  before do
    # Create test data example
    @knight = Knight.create(:x_position => 3, :y_position => 3)
  end

  it "should know if x or y move is two then the next x or y move is one vice versa" do
    # Example move
    x_top_x = 1
    x_bottom_x = 5
    x_left_y = 2
    x_right_y = 4

    y_top_x = 2
    y_bottom_x = 4
    y_left_y = 1
    y_right_y = 5

    # Calculate old move and new move
    x_top_x = (@knight.x_position - x_top_x).abs # => 2
    x_bottom_x = (@knight.x_position - x_bottom_x).abs # => 2
    x_left_y = (@knight.y_position - x_left_y).abs # => 1
    x_right_y = (@knight.y_position - x_right_y).abs # => 1

    y_top_x = (@knight.x_position - y_top_x).abs # => 1
    y_bottom_x = (@knight.x_position - y_bottom_x).abs # => 1
    y_left_y = (@knight.y_position - y_left_y).abs # => 2
    y_right_y = (@knight.y_position - y_right_y).abs # => 2

    expect(x_top_x).to be == 2
    expect(x_bottom_x).to be == 2
    expect(x_left_y).to be == 1
    expect(x_right_y).to be == 1

    expect(y_top_x).to be == 1
    expect(y_bottom_x).to be == 1
    expect(y_left_y).to be == 2
    expect(y_right_y).to be == 2
  end

end
