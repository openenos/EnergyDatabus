class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :full_name
      t.string :phone

      t.timestamps
    end
  end
end
