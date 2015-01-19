class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :company_name
      t.string :company_reference
      t.integer :user_id

      t.timestamps
    end
  end
end
