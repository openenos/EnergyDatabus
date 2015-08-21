class CreatePanels < ActiveRecord::Migration
  def change
    create_table :panels do |t|
      t.string :emon_url
      t.string :equip_ref
      t.string :panel_type
      t.integer :parent_panel_id
      t.integer :site_id
      t.integer :no_of_circuits
      t.integer :amp

      t.timestamps
    end
  end
end
