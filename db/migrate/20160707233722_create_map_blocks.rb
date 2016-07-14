class CreateMapBlocks < ActiveRecord::Migration
  def change
    create_table :map_blocks do |t|
      t.integer     :row, null: false
      t.integer     :col, null: false
      t.references  :map, index: true, foreign_key: true
      t.timestamps  null: false
    end
  end
end
