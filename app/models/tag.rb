class Tag < ActiveRecord::Base
  belongs_to :link
  belongs_to :tag_type
  attr_accessible :tag_type_id, :link_id

  def self.tag_link(link, input)


    tag_type = TagType.find_by_tag_name(input)
    tag_type = TagType.create(:tag_name => input) if tag_type.nil?

    Tag.create(:tag_type_id => tag_type.id, :link_id => link.id)
  end

end