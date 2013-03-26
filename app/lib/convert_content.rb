module ConvertContent
  def self.included(base)
    base.send :include, InstanceMethods
    base.class_eval do
      before_save :convert_content
    end
  end

  module InstanceMethods
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
end


