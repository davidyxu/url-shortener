class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :link
  has_many :comments
#  belongs_to :parent, :class_name => :comment, :foreign_key => :parent_id
  attr_accessible :user_id, :link_id, :body, :parent_id
  def self.add(user, link, body, parent = 1)
    Comment.create(:user_id => user.id, :link_id => link.id, :body => body, :parent_id => parent)
  end
end