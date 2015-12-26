require 'rails_helper'
require 'rook'

RSpec.describe Rook, type: :model do
	before do 
		@game = Game.create
		@game.clear_board!
		@rookb = Rook.create(:game => @game, :color => 0, :x_position => 0, :y_position => 0)
		@rookw = Rook.create(:game => @game, :color => 1, :x_position => 7, :y_position => 7)


	end

	it "should allow a horizontal move" do
		expect(@rookb.valid_move?(0, 6)).to eq(true)
		expect(@rookw.valid_move?(7, 5)).to eq(true)
	end

	it "should allow a vertical move" do
    	expect(@rookb.valid_move?(6, 0)).to eq(true)
    	expect(@rookw.valid_move?(4, 7)).to eq(true)
   	end

	it "should only allow a move that is horizontal or vertical" do
    	expect(@rookb.valid_move?(2, 6)).to eq(false)
    	expect(@rookw.valid_move?(3, 6)).to eq(false)
	end

	it "should not allow a move off the board" do
		expect(@rookb.valid_move?(0, 8)).to eq(false)
		expect(@rookb.valid_move?(0, -1)).to eq(false)
		expect(@rookw.valid_move?(8, 0)).to eq(false)
		expect(@rookw.valid_move?(-1, 0)).to eq(false)
	end

	it "should not allow a move if the path is obstructed" do
		@rookb.update_attributes(:x_position => 5, :y_position => 7)
		expect(@rookw.valid_move?(0, 7)).to eq(false)
	end

end