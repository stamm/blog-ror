class AddContentDisplayToComment < ActiveRecord::Migration
  def change
    add_column :comments, :content_display, :text, null: false
  end
end
