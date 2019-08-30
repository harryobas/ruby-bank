class AutoIncrementAccountid < ActiveRecord::Migration[5.1]
  def up
    change_column :accounts, :id, :integer, limit: 8, auto_increment: true
  end

  def down
    change_column :account, :id, :integer
  end
end
