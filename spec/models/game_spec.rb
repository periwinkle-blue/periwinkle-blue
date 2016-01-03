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

  it "should know the positions of the kings" do
    king_1 = King.create(:x_position => 3, :y_position => 3, :type => 'King', :color => 1, :game => @game)
    king_0 = King.create(:x_position => 5, :y_position => 5, :type => 'King', :color => 0, :game => @game)

    piece_1 = @game.find_king(king_1, 1)
    piece_0 = @game.find_king(king_0, 0)
    expect(piece_1).to eq(king_1)
    expect(piece_1.x_position).to eq(3)
    expect(piece_1.y_position).to eq(3)
    expect(piece_0).to eq(king_0)
    expect(piece_0.x_position).to eq(5)
    expect(piece_0.y_position).to eq(5)
  end

end
