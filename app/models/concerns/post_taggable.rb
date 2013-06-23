module PostTaggable
  extend ActiveSupport::Concern

  included do
    scope :scope_tag, (lambda do |tag|
      tag = Tag.select('id').find_by(name: tag.downcase)
      if tag
        joins(:posts_tags).where(posts_tags: { tag_id: tag.id })
      else
        none
      end
    end)
  end

  def tag_list
    self.tags.map { |t| t.name }.join(', ')
  end

  def tag_list=(value)
    tag_names = value.split(/\s*,\s*/)
    self.tags = tag_names.map do |name|
      Tag.find_by(name: name.downcase) || Tag.create(tag_params(name))
    end
  end

  def tag_array
    self.tags.map { |t| t.name }
  end

  private

  def tag_params(name)
    ActionController::Parameters.new({ name: name.downcase }).permit(:name)
  end
end