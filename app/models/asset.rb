class Asset < ActiveRecord::Base
  belongs_to :post
  has_attached_file :image,
    styles: {
        thumb: '100x100#',
        small: '300x300>',
        large: '600x600>'
    }
  validates_attachment_content_type :image, content_type: /image/
  validates_attachment_size :image, in: 0..10.megabytes

  validates_attachment_presence :image
  #validates_attachment_size :image, :less_than => 500.kilobytes

  def to_i
    self.id
  end
end
