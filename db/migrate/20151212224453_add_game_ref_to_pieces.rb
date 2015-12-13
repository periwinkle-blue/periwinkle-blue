class AddGameRefToPieces < ActiveRecord::Migration
  def change
    add_reference :pieces, :game, index: true, foreign_key: true
  end
end
