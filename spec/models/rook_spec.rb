require 'rails_helper'
require 'rook'

RSpec.describe Rook, type: :model do
	before do 
		@game = Game.create
		@game.clear_board_pieces
		@rook = Rook.create(:game => @game, :color => 0, :x_position => 0, :y_position => 0)

	end

	it "should allow a horizontal move" do
		expect(@rook.valid_move?(0, 6)).to eq(true)
	end

	it "should allow a vertical move" do
    	expect(@rook.valid_move?(6, 0)).to eq(true)
	end

	it "should only allow a move that is horizontal or vertical" do
    	expect(@rook.valid_move?(2, 6)).to eq(false)
	end

	it "should not allow a move off the board" do
		expect(@rook.valid_move?(0, 8)).to eq(false)
		expect(@rook.valid_move?(0, -1)).to eq(false)
		expect(@rook.valid_move?(8, 0)).to eq(false)
		expect(@rook.valid_move?(-1, 0)).to eq(false)
	end

end