class UpdateFirstMoveColumnInPieces < ActiveRecord::Migration
  def change
    rename_column :pieces, :first_move, :moved
  end
end
