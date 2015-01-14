class CreateCircuits < ActiveRecord::Migration
  def change
    create_table :circuits do |t|
      t.boolean :active
      t.boolean :input
      t.string :breaker_number
      t.boolean :double_breaker
      t.integer :breaker_size
      t.string :display
      t.integer :elec_load_type_id
      t.integer :panel_id
      t.integer :ct_sensor_type
      t.boolean :double_ct
      t.string :channel_no

      t.timestamps
    end
  end
end
