class TagType < ActiveRecord::Base
  has_many :tags
  has_many :links, :through => :tags
  attr_accessible :tag_name

end