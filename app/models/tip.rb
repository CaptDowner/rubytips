class Tip < ActiveRecord::Base
  include PgSearch
  attr_accessible :applies_to, :category, :email, :firstname, :lastname, :posted, :rubytype, :source, :subject, :tip, :xmail
  paginates_per 20
  
#  validates :xmail, :numericality => true, :allow_nil => true
#  validates_length_of :xmail, :is => 6, :allow_nil => true, :message => 'Reference must be contain 6 digits'
#  validates :email, :presence => true, :email => true
    
  pg_search_scope :search, :against => [:category, :tip, :email]

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
end
