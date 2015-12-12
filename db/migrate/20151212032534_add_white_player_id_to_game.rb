class AddWhitePlayerIdToGame < ActiveRecord::Migration
  def change
    add_column :games, :white_player_id, :integer
  end
end
