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
#  user_id       :integer          default(0), not null
#  url             :string(255)      not null
#  short_url       :string(255)      default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Post < ActiveRecord::Base

  has_and_belongs_to_many :tags
  has_many :comments
  has_many :posts_tags
  belongs_to :user
  STATUS_TYPES = [ :draft, :publish, :archive ]

  validates :title, :content, :post_time, :url, :status, presence: true
  validates :url, uniqueness: true

  before_save :convert_content


  scope :published, -> { where(:status => STATUS_TYPES.index(:publish) + 1) }
  scope :ordered, -> { order "post_time DESC, #{table_name}.id DESC" }

  scope :scope_tag, lambda { |tag|
    tag_id = Tag.where(name: tag.downcase).select('id').first.id
    none unless tag_id
    joins(:posts_tags).where(posts_tags: {tag_id: tag_id})
  }

  def content_display
    attr = self.read_attribute(:content_display)
    return attr unless attr.blank?
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
    tag_names = value.split(/\s*,\s*/)
    self.tags = tag_names.map do |name|
      parameters = ActionController::Parameters.new({name: name.downcase})
      Tag.where('name = ?', name.downcase).first or Tag.create(parameters.permit(:name))
    end
  end

  def tag_array
    self.tags.map { |t| t.name }
  end



  def get_status
    STATUS_TYPES[status-1]
  end

end
