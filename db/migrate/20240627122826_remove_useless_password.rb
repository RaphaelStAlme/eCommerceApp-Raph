class RemoveUselessPassword < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :password
  end
enddb
