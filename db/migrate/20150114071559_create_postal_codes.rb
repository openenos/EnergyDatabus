class CreatePostalCodes < ActiveRecord::Migration
  def change
    create_table :postal_codes do |t|
      t.string :geo_postal_code
      t.string :geo_city
      t.string :geo_state
      t.string :geo_country
      t.string :tz
      t.string :weather_ref

      t.timestamps
    end
  end
end
