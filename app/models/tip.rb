class Tip < ActiveRecord::Base
# enables multi field search of PostgreSQL dbs
include PgSearch
  has_one :user
  paginates_per 20

  validates :subject, :presence => true 
  validates :rubytype, :presence => true
  validates :tip, :length => {:minimum => 18}, :presence => true
  validates :xmail, :numericality => true, :allow_nil => true
  validates_length_of :xmail, :is => 6, :allow_nil => true
  validates :email, :presence => true, allow_nil: true, format:  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :posted, :presence => true
  validates :category, :presence => true
  validates :source, :presence => true
  validates :applies_to, :presence => true

  # specify db fields to include for searches
  pg_search_scope :search, :against => [:category, :tip, :email]

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
end
