class RemoveGameIdFromPieces < ActiveRecord::Migration
  def change
  	remove_column :pieces, :game_id, :integer
  end
end
