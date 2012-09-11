class Comment < ActiveRecord::Base
  STATUS_TYPES = [ :pending, :approve, :spam ]
  attr_accessible :author, :content, :email, :url, :ip, :status
  belongs_to :post
  validates :author, :email, :content, presence: true
  validates :email, email: {message: I18n.t(:wrong_email)}

  scope :last_first, order("created_at DESC")

  def get_status
    STATUS_TYPES[status-1]
  end

  def self.get_status(status)
    STATUS_TYPES.index(status) + 1
  end


end
