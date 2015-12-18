class AddIconToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :icon, :string
  end
end
