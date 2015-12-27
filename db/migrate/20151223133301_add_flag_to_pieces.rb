class AddFlagToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :first_move, :boolean
  end
end
