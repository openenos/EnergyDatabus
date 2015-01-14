class CreateUtilities < ActiveRecord::Migration
  def change
    create_table :utilities do |t|
      t.string :display
      t.string :utility_type
      t.float :base_rate
      t.boolean :demand
      t.float :tier1_rate
      t.float :tier2_rate
      t.float :tier3_rate

      t.timestamps
    end
  end
end
