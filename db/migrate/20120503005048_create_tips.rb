class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :source
      t.string :rubytype
      t.string :subject
      t.string :category
      t.text :tip
      t.string :applies_to
      t.string :email
      t.timestamp :posted
      t.string :firstname
      t.string :lastname

      t.timestamps
    end
  end
end
