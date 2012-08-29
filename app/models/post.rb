class Post < ActiveRecord::Base
  has_many :post_tags
  has_many :tags, through: :post_tags
  STATUS_TYPES = [ :draft, :publish, :archive ]
  #STATUS_TYPES = [ 'test']
  attr_accessible :author_id, :content, :content_display, :post_time, :short_url, :status, :title, :url

  validates :title, :content, :post_time, :url, :status, presence: true

  before_save :convert_content
  #before_save :convert_post_time
  def validate
    self.post_time = Date.strptime(self.post_time).to_time.to_i
  end

  scope :published, where(:status => STATUS_TYPES.index(:publish) + 1)


  def convert_content
    return if self.content.nil?
    self.content_display = RedCloth.new(self.content).to_html
  end

  def post_time=(value)
  #def convert_post_time
    #self.post_time = Date.strptime(self.post_time).to_time.to_i
    write_attribute :post_time, Date.strptime(value).to_time.to_i
  end


  def get_status
    STATUS_TYPES[status-1]
  end
end
