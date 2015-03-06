class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :topic
  
  
  default_scope { order('rank DESC') }
  scope :visible_to, -> (user) {user ? all : joins(:topic).where('topics.public' => true) }
  
  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true
  
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
    }
  
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  def up_votes
    self.votes.where(value: 1).count
  end
  
  def down_votes
    self.votes.where(value: -1).count
  end
  
  def points
    self.votes.sum(:value)
  end
  
  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24) # 1 day in seconds
    new_rank = self.points + age_in_days
    
    update_attribute(:rank, new_rank)
  end
end
