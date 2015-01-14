class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :geo_addr
      t.integer :postal_code_id
      t.decimal :geo_lat, :precision=>16, :scale=>4
      t.decimal :geo_lng, :precision=>16, :scale=>4
      t.integer :utility_id

      t.timestamps
    end
  end
end
