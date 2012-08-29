class CreatePostTags < ActiveRecord::Migration
  def change
    create_table :post_tags do |t|
      t.integer :post_id, null: false, default: 0
      t.integer :tag_id, null: false, default: 0
    end
  end
end
