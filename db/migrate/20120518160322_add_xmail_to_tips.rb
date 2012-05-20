class AddXmailToTips < ActiveRecord::Migration
  def change
    add_column :tips, :xmail, :string
  end
end
