require 'rails_helper'
require 'bishop'

RSpec.describe Bishop, type: :model do
  
  before do
    @game = Game.create
    @game.clear_board!
    
    @bishop = Bishop.create( :x_position => 2, :y_position => 4, :game => @game )
  end
  
  describe "#valid_move" do
    
    context 'given valid diagonal parameters' do
      it "returns true" do
        expect(@bishop.valid_move?(0,2)).to eq(true)
        expect(@bishop.valid_move?(1,5)).to eq(true)
        expect(@bishop.valid_move?(6,0)).to eq(true)
        expect(@bishop.valid_move?(4,6)).to eq(true)
      end
    end
    
    context 'given invalid diagonal parameters' do
      it "returns false" do
        expect(@bishop.valid_move?(0,5)).to eq(nil)
        expect(@bishop.valid_move?(1,0)).to eq(nil)
        expect(@bishop.valid_move?(6,3)).to eq(nil)
        expect(@bishop.valid_move?(2,7)).to eq(nil)
      end
    end
    
    context 'given out of bound parameters' do
      it "returns false" do
        expect(@bishop.valid_move?(6,8)).to eq(false)
        expect(@bishop.valid_move?(-1,1)).to eq(false)
      end
    end
    
  end
  
end
