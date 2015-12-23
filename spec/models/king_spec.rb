require 'rails_helper'
require 'king'

RSpec.describe King, type: :model do

  before do
    # Create test data example
    @king = King.create(:x_position => 3, :y_position => 3)
  end

  it "it should only allow one move" do
    expect(@king.valid_move?(3, 2)).to eq(true)
    expect(@king.valid_move?(3, 4)).to eq(true)
    expect(@king.valid_move?(2, 3)).to eq(true)
    expect(@king.valid_move?(4, 3)).to eq(true)
  end

end
