class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.text :content_display, null: false
      t.column :status, :tinyint, null: false
      t.integer :post_time, null: false, default: 0
      t.integer :author_id, null: false, default: 0
      t.string :url, null: false
      t.string :short_url, null: false, default: ''

      t.timestamps
    end
  end
end
