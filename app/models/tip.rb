class Tip < ActiveRecord::Base
  include PgSearch
  attr_accessible :applies_to, :category, :email, :firstname, :lastname, :posted, :rubytype, :source, :subject, :tip, :xmail
  paginates_per 20
  
  validates :firstname, :presence => true
  validates :lastname, :presence => true 
  validates :subject, :presence => true 
  validates :rubytype, :presence => true
  validates :tip, :length => {:minimum => 18}, :presence => true 
  validates :xmail, :numericality => true, :allow_nil => true
  validates_length_of :xmail, :is => 6, :allow_nil => true
  validates :email, :presence => true, :email => true  
  validates :category, :presence => true
  validates :source, :presence => true
  validates :applies_to, :presence => true
    
  pg_search_scope :search, :against => [:category, :tip, :email]

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
end

=begin

   New rails3 validations:

    validates :login, :presence => true, :length => {:minimum => 4},
              :uniqueness => true, :format => { :with => /[A-Za-z0-9]+/ }

    :presence => true
    :uniqueness => true
    :numericality => true
    :length => { :minimum => 0, maximum => 2000 }
    :format => { :with => /.*/ }
    :inclusion => { :in => [1,2,3] }
    :exclusion => { :in => [1,2,3] }
    :acceptance => true
    :confirmation => true
=end   




