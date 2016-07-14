class CreatePassengers < ActiveRecord::Migration
  def change
    create_table :passengers do |t|
      t.string      :name,      null: false
      t.references  :map,       index: true, foreign_key: true
      t.references  :taxi,      index: true, foreign_key: true      
      t.integer     :row,       null: false
      t.integer     :col,       null: false
      t.integer     :dest_row,  null: false
      t.integer     :dest_col,  null: false
      t.integer     :status,    null: false

      t.timestamps  null: false
    end
  end
end
