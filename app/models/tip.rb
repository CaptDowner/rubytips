class Tip < ActiveRecord::Base
  include PgSearch
  attr_accessible :applies_to, :category, :email, :firstname, :lastname, :posted, :rubytype, :source, :subject, :tip
  paginates_per 20 
  
  pg_search_scope :search, :against => [:category, :tip]

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
end
