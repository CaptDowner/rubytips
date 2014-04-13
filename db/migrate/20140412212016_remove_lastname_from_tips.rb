class RemoveLastnameFromTips < ActiveRecord::Migration
  def change
    remove_column :tips, :lastname, :string
  end
end
