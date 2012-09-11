class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, null: false, default: ''
      t.integer :status, null: false, default: 0
      t.string :author, null: false, default: ''
      t.string :email, null: false, default: ''
      t.string :url, null: false, default: ''
      t.integer :post_id, null: false, default: 0
      t.string :ip, null: false, default: ''

      t.timestamps
    end
  end
end
