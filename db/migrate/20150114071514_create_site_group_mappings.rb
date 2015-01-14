class CreateSiteGroupMappings < ActiveRecord::Migration
  def change
    create_table :site_group_mappings do |t|
      t.integer :site_group_id
      t.integer :site_id

      t.timestamps
    end
  end
end
