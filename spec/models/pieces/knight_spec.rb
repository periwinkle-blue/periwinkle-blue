require 'rails_helper'
require 'knight'

RSpec.describe Knight, type: :model do

  before do
    # Create test data example
    @game = Game.create
    @game.clear_board!
    @knight = Knight.create(:x_position => 3, :y_position => 3, :game => @game)
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
