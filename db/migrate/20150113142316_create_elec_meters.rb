class CreateElecMeters < ActiveRecord::Migration
  def change
    create_table :elec_meters do |t|
      t.string :meter_type
      t.string :meter_main
      t.string :display
      t.integer :site_id
      t.integer :meter_loc
      t.string :phase
      t.integer :amp
      t.integer :volt

      t.timestamps
    end
  end
end
