class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts force: :cascade do |t|
      t.decimal :balance

      t.integer :user_id, limit: 4

      t.timestamps
    end
  end
end
