class AddAccountIdToAllModels < ActiveRecord::Migration
  def change
  	add_column :users, :account_id, :integer
  	add_column :circuits, :account_id, :integer
  	add_column :elec_meters, :account_id, :integer
  	add_column :locations, :account_id, :integer
  	add_column :panels, :account_id, :integer
  	add_column :postal_codes, :account_id, :integer
  	add_column :sites, :account_id, :integer
  	add_column :site_groups, :account_id, :integer
  	add_column :site_group_mappings, :account_id, :integer
  end
end
