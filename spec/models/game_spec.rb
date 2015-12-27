require 'rails_helper'
require 'piece'

RSpec.describe Game, type: :model do
  
  before do
    @game = Game.create
    @game.clear_board!
  end
  
  it "should find matching piece in the game" do
    bishop = Bishop.create(:x_position => 0, :y_position => 4, :color => 1, :game => @game)
    
    piece = @game.find_piece_icon(0, 4)
    expect(piece).not_to eq("")
  end
  
  it "shouldn't find matching piece in the game" do
    bishop = Bishop.create(:x_position => 0, :y_position => 4, :color => 1, :game => @game)
    
    piece = @game.find_piece_icon(0, 3)
    expect(piece).to eq("")
  end
  
end
