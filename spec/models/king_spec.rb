require 'rails_helper'
require 'king'

RSpec.describe King, type: :model do

  describe 'valid_move?' do
    it "should know the current x and y position" do
      king = King.create( :x_position => 7, :y_position => 4)
      expect(king.x_position).to eq(7)
      expect(king.y_position).to eq(4)
    end
  end

end
