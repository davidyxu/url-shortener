class LongURL < ActiveRecord::Base
  has_many :links
  attr_accessible :url
end