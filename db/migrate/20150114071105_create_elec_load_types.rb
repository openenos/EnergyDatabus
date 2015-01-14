class CreateElecLoadTypes < ActiveRecord::Migration
  def change
    create_table :elec_load_types do |t|
      t.string :load_type
      t.string :dispaly

      t.timestamps
    end
  end
end
