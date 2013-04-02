class Visit < ActiveRecord::Base
  belongs_to :user
  belongs_to :link
  attr_accessible :user_id, :link_id

  def self.record_visit(user, link)
    Visit.create(:link_id => link.id, :user_id => user.id)
  end
end