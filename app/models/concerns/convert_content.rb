module ConvertContent
  extend ActiveSupport::Concern

  included do
    before_save :convert_content
  end

  def content_display
    attr = self.read_attribute(:content_display)
    return attr unless attr.blank?
    convert_content_and_save
  end

  def convert_content_and_save
    result = convert_content
    save
    result
  end

  def convert_content
    return if self.content.nil?
    self.content_display = MarkdownRenderer.markdown self.content
  end
end


