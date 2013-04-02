class User < ActiveRecord::Base
  has_many :links
  has_many :comments
  has_many :visits
  attr_accessible :username
  attr_accessible :email

  def shorten_link(link)
    Link.shorten(self, link)
  end

  def visit(link)
    Visit.record_visit(self, link)
  end
end