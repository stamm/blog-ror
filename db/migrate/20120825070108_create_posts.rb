class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.text :content_display
      t.integer :status
      t.integer :post_time
      t.integer :author_id
      t.string :url
      t.string :short_url

      t.timestamps
    end
  end
end
