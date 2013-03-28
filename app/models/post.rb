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

  include ConvertContent
  include PostTime
  include PostTaggable

  STATUS_TYPES = [ :draft, :publish, :archive ]

  has_many :comments
  has_many :posts_tags
  has_and_belongs_to_many :tags
  belongs_to :user

  scope :published, -> { where(status: STATUS_TYPES.index(:publish) + 1) }
  scope :ordered, -> { order(post_time: :desc, id: :desc) }

  validates :title, :content, :post_time, :url, :status, presence: true
  validates :url, uniqueness: true

  def get_status
    STATUS_TYPES[status-1]
  end
end
