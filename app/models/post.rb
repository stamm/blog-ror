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
  include PostSearch

  STATUS_TYPES = %i(draft publish archive)

  has_many :comments
  has_many :posts_tags
  has_and_belongs_to_many :tags
  belongs_to :user
  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets, allow_destroy: true


  scope :published, -> { where(status: self.get_status(:publish)) }
  scope :ordered, -> { order(post_time: :desc, id: :desc) }

  validates :title, :content, :post_time, :url, :status, presence: true
  validates :url, uniqueness: true

  before_validation :check_assets

  def check_assets
    self.assets.each do |asset|
      unless asset.image.file?
        if asset.new_record?
          self.assets.delete(asset)
        else
          asset.destroy
        end
      end
    end
  end

  def get_status
    STATUS_TYPES[status-1]
  end

  def self.get_status(status)
    STATUS_TYPES.index(status) + 1
  end
end
