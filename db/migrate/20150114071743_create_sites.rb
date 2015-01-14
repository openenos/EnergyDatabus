class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.integer :area_gross_square_foot
      t.string :site_ref
      t.string :display
      t.integer :year_built
      t.integer :area_cond_square_foot
      t.integer :operating_hours
      t.integer :location_id

      t.timestamps
    end
  end
end
