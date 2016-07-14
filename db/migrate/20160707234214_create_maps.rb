class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string      :name, null: false
      t.integer     :rows, null: false
      t.integer     :cols, null: false
      t.integer     :time, null: false
      t.timestamps  null: false
    end
  end
end
