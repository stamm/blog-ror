class Post < ActiveRecord::Base
  has_many :post_tags
  has_many :tags, through: :post_tags
  STATUS_TYPES = [ :draft, :publish, :archive ]
  #STATUS_TYPES = [ 'test']
  attr_accessible :author_id, :content, :content_display, :post_time, :short_url, :status, :title, :url

  attr_accessible :tag_list, :post_time_string

  validates :title, :content, :post_time, :url, :status, presence: true

  before_save :convert_content
  #before_save :convert_post_time


  scope :published, where(:status => STATUS_TYPES.index(:publish) + 1)


  def self.scope_tag(tag)
    joins(:tags).where('tags.name = ?', tag)
  end


  def convert_content
    return if self.content.nil?
    self.content_display = RedCloth.new(self.content).to_html
  end


  def post_date
    Time.at(self.post_time).strftime('%F')
  end


  def post_time_string
    Time.at(self.post_time).strftime('%F %T')
  end

  def post_time_string=(value)
    write_attribute :post_time, Date.strptime(value).to_time.to_i
  end

  def tag_list
    self.tags.map { |t| t.name }.join(', ')
  end

  def tag_list=(value)
    tag_names = value.split(/,\s+/)
    self.tags = tag_names.map { |name| Tag.where('name = ?', name).first or Tag.create(name: name)}
  end

  def tag_array
    self.tags.map { |t| t.name }
  end



  def get_status
    STATUS_TYPES[status-1]
  end
end
