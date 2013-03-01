# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)      default(""), not null
#  password_digest :string(255)      default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_many :posts
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { maximum: 255 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  has_secure_password

  before_save { self.name.downcase! }
end
