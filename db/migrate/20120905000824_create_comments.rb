class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :status
      t.string :author
      t.string :email
      t.string :url
      t.integer :post_id
      t.string :ip

      t.timestamps
    end
  end
end
