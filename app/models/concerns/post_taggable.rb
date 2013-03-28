module PostTaggable
  extend ActiveSupport::Concern

  included do
    scope :scope_tag, lambda { |tag|
      tag = Tag.where(name: tag.downcase).select('id').first
      if tag
        joins(:posts_tags).where(posts_tags: {tag_id: tag.id})
      else
        none
      end
    }
  end

  def tag_list
    self.tags.map { |t| t.name }.join(', ')
  end

  def tag_list=(value)
    tag_names = value.split(/\s*,\s*/)
    self.tags = tag_names.map do |name|
      Tag.find_by(name: name.downcase) or Tag.create(tag_params(name))
    end
  end

  def tag_array
    self.tags.map { |t| t.name }
  end

private
  def tag_params(name)
    ActionController::Parameters.new({name: name.downcase}).permit(:name)
  end
end