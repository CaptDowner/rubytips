class RemoveFirstnameFromTips < ActiveRecord::Migration
  def change
    remove_column :tips, :firstname, :string
  end
end
