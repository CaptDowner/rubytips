class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :source
      t.string :rubytype
      t.string :subject
      t.string :category
      t.string :applies_to
      t.string :email
      t.timestamp :posted
      t.string :xmail
      t.text :tip
      t.integer :user_id

      t.timestamps
    end
  end
end
