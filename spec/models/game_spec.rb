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
=begin
  it "should look through horizontally for rooks or queen" do
    king = King.create(:x_position => 3, :y_position => 2, :type => 'King', :color => 1, :game => @game)
    #rook = Rook.create(:x_position => 3, :y_position => 4, :type => 'Rook', :color => 0, :game => @game)
    rook = Rook.create(:x_position => 3, :y_position => 1, :type => 'Rook', :color => 0, :game => @game)
    #queen = Queen.create(:x_position => 3, :y_position => 3, :type => 'Queen', :color => 0, :game => @game)
    #pawn = Pawn.create(:x_position => 3, :y_position => 7, :type => 'Pawn', :color => 0, :game => @game)
    #target_square_1 = @game.pieces.create(:x_position => 3, :y_position => 7)
    #target_square_2 = @game.pieces.create(:x_position => 3, :y_position => 0)

    # Pass current position of King to check
    expect(@game.king_in_check?("King", king.color)).to eq(true)

  end
=end
  it "should look through vertically for rooks or queen" do
    king = King.create(:x_position => 3, :y_position => 2, :type => 'King', :color => 1, :game => @game)
    #rook = Rook.create(:x_position => 3, :y_position => 4, :type => 'Rook', :color => 0, :game => @game)
    #rook = Rook.create(:x_position => 7, :y_position => 2, :type => 'Rook', :color => 0, :game => @game)
    queen = Queen.create(:x_position => 6, :y_position => 2, :type => 'Queen', :color => 0, :game => @game)
    #pawn = Pawn.create(:x_position => 7, :y_position => 2, :type => 'Pawn', :color => 0, :game => @game)
    #target_square_1 = @game.pieces.create(:x_position => 3, :y_position => 7)
    #target_square_2 = @game.pieces.create(:x_position => 3, :y_position => 0)

    # Pass current position of King to check
    expect(@game.king_in_check?("King", king.color)).to eq(true)

  end

end
