class AddBlackPlayerIdToGame < ActiveRecord::Migration
  def change
    add_column :games, :black_player_id, :integer
  end
end
