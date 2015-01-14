class CreateSiteGroups < ActiveRecord::Migration
  def change
    create_table :site_groups do |t|
      t.string :display

      t.timestamps
    end
  end
end
