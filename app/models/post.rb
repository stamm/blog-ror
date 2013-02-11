# == Schema Information
#
# Table name: posts
#
#  id              :integer          not null, primary key
#  title           :string(255)      not null
#  content         :text             default(""), not null
#  content_display :text             default(""), not null
#  status          :integer          not null
#  post_time       :integer          default(0), not null
#  author_id       :integer          default(0), not null
#  url             :string(255)      not null
#  short_url       :string(255)      default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Post < ActiveRecord::Base

  has_and_belongs_to_many :tags
  has_many :comments
  STATUS_TYPES = [ :draft, :publish, :archive ]
  #STATUS_TYPES = [ 'test']
  attr_accessible :author_id, :content, :content_display, :post_time, :short_url, :status, :title, :url

  attr_accessible :tag_list, :post_time_string

  validates :title, :content, :post_time, :url, :status, presence: true
  validates :url, uniqueness: true

  before_save :convert_content
  #before_save :convert_post_time


  scope :published, -> { where(:status => STATUS_TYPES.index(:publish) + 1) }

  scope :scope_tag, lambda { |tag| joins(:tags).where('tags.name = ?', tag) }

  def content_display
    attr = self.read_attribute(:content_display)
    return attr if attr
    convert_content
  end


  def convert_content
    return if self.content.nil?
    self.content_display = MarkdownRenderer.markdown self.content
  end


  def post_date
    Time.zone.at(self.post_time).strftime('%F')
  end


  def post_time_string
    Time.zone.at(self.post_time).strftime('%F %T')
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
