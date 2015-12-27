require 'rails_helper'
require 'knight'

RSpec.describe Knight, type: :model do

  before do
    # Create test data example
    @knight = Knight.create(:x_position => 3, :y_position => 3)
  end

  it "it should allow two moves vertically and then allow only one move horizontally" do
    expect(@knight.valid_move?(1, 2)).to eq(true)
    expect(@knight.valid_move?(1, 4)).to eq(true)
    expect(@knight.valid_move?(5, 2)).to eq(true)
    expect(@knight.valid_move?(5, 4)).to eq(true)
  end

  it "it should allow two moves horizontally and then allow only one move vertically" do
    expect(@knight.valid_move?(1, 2)).to eq(true)
    expect(@knight.valid_move?(1, 4)).to eq(true)
    expect(@knight.valid_move?(5, 2)).to eq(true)
    expect(@knight.valid_move?(5, 4)).to eq(true)
  end

end
