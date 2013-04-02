class Link < ActiveRecord::Base
  attr_accessible :long_url_id, :shortened_link, :user_id
  has_many :tags
  has_many :tag_types, :through => :tags
  has_many :visits
  has_many :comments
  belongs_to :long_url
  belongs_to :user

  def self.shorten(user, link)
    short_key = SecureRandom.urlsafe_base64(4)
    url_ref = LongURL.find_by_url(link)
    url_ref = LongURL.create(:url => link) if url_ref.nil?
    Link.create(:long_url_id => url_ref.id, :shortened_link => short_key,
    :user_id => user.id)
  end

  def tag(type)
    Tag.tag_link(self, type)
  end

  def count_visits
    self.visits.length #REV: Could use just visits.count. That inserts COUNT into the SQL statement 
                             #and leverages SQL instead of the length array method.
  end

  def unique_visits
    Visit.count(:user_id, distinct: true, :conditions => ["link_id = ?", self.id])
  end

  def recent_visits
    Visit.count(:conditions => ["link_id = ? AND created_at > ?", self.id, 10.minutes.ago])
  end

  def self.most_popular(type)
    tag = TagType.find_by_tag_name(type)
    relevant_links = tag.links.map { |link| link.id}
    popular = Visit.where(:link_id => relevant_links).group(:link_id).count(:user_id)
    Link.find(popular.keys[0].to_i)
  end
end