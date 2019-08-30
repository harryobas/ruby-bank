class AutoIncrementUserid < ActiveRecord::Migration[5.1]
  def up
    change_column :users, :id, :integer, limit: 8, auto_increment: true
  end

  def down
    change_column :users, :id, :integer
  end
end
