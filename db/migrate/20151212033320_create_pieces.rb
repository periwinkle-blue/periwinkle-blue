class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|

    	t.string :type
    	t.integer :x_position
    	t.integer :y_position
    	t.integer :color

      t.timestamps
    end
  end
end
