class CreateTaxis < ActiveRecord::Migration
  def change
    create_table :taxis do |t|
      t.string      :name,      null: false
      t.integer     :status,    null: false
      t.integer     :row,       null: false
      t.integer     :col,       null: false
      t.references  :map,       index: true, foreign_key: true
      t.timestamps  null: false
    end
  end
end
