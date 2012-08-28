class Post < ActiveRecord::Base
  STATUS_TYPES = [ :draft, :publish, :archive ]
  #STATUS_TYPES = [ 'test']
  attr_accessible :author_id, :content, :content_display, :post_time, :short_url, :status, :title, :url

  validates :title, :content, :post_time, :url, :status, presence: true


  scope :published, where(:status => STATUS_TYPES.index(:publish) + 1)

  def get_status
    STATUS_TYPES[status-1]
  end
end
