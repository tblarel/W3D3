class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true, uniqueness: true 

  def self.random_code
    code = SecureRandom::urlsafe_base64
    until !ShortenedUrl.exists?(['short_url = ?', code] )
      self.random_code
    end
    code
  end

  def self.create_short_url(user, long_url)
    ShortenedUrl.create!( long_url: long_url, short_url: ShortenedUrl.random_code, user_id: user.id )
  end
  
  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :short_url_id,
    primary_key: :id
  )

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many :visitors,
    Proc.new { distinct }, #<<<
    through: :visits,
    source: :user

  # has_many :visitors, 
  #   through: :visits, 
  #   source: :user 
  
  def num_clicks 
    self.visitors.count
  end

  # def num_uniques 
  #   Visit.select(COUNT(DISTINCT :user_id)).where(short_url_id: self.id)
  # end 

  # def num_recent_uniques 
  #   Visit.select(COUNT(DISTINCT :user_id)).where(short_url_id: self.id, updated_at < (self.updated_at - 600) )
  # end

end
