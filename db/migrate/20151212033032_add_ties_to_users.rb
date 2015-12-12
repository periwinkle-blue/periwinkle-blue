class AddTiesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ties, :integer
  end
end
