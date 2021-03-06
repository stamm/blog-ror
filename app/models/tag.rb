# == Schema Information
#
# Table name: tags
#
#  id        :integer          not null, primary key
#  name      :string(255)      not null
#  frequency :integer          default(0), not null
#

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts

  def self.tags
    Tag.all.reduce({}) do |set, tag|
      set[tag.name] = tag.frequency
      set
    end
  end

  def self.recount_frequency
    Tag.all.each do |tag|
      count = PostsTag.where(tag_id: tag.id).count
      tag.update(frequency: count)
    end
  end
end
