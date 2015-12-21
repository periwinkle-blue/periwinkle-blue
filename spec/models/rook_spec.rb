require 'rails_helper'
require 'rook'

RSpec.describe Rook, type: :model do
	before do 
		@rook = Rook.create(:x_position => 0, :y_position => 0)
	end

	it "should be valid with a move in the same row" do
		valid_move = @rook.valid_move?(0, 6)
    	expect(valid_move).to eq(true)
	end

	it "should be valid with a move in the same column" do
		valid_move = @rook.valid_move?(6, 0)
    	expect(valid_move).to eq(true)
	end

	it "should not be valid with a move to a different row and column" do
		valid_move = @rook.valid_move?(2, 6)
    	expect(valid_move).to eq(false)
	end

end
