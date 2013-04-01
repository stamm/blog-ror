# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text             default(""), not null
#  status     :integer          default(0), not null
#  author     :string(255)      default(""), not null
#  email      :string(255)      default(""), not null
#  url        :string(255)      default(""), not null
#  post_id    :integer          default(0), not null
#  ip         :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  include ConvertContent
  STATUS_TYPES = %i(pending approve spam)
  belongs_to :post
  validates :author, :email, :content, presence: true
  validates :email, email: {message: I18n.t(:wrong_email)}

  scope :last_first, -> { order('created_at' => :desc) }
  scope :approved, -> { where(status: self.get_status(:approve)) }
  scope :not_spam, -> { where.not(status: self.get_status(:spam)) }

  def get_status
    STATUS_TYPES[status-1]
  end

  %i(approve spam).each do |val|
    define_method "set_#{val}" do
      self.status = self.class.get_status(val)
      save
    end
  end

  def self.get_status(status)
    STATUS_TYPES.index(status) + 1
  end
end
