class Tip < ActiveRecord::Base
include PgSearch

#  class EmailValidator < ActiveRecord::Validator
#    def validate()
#      record.errors[:email] << "is not valid" unless
#        record.email =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
#    end
#  end

#  validates_with EMailValidator
  paginates_per 20

  validates :firstname, :presence => true
  validates :lastname, :presence => true 
  validates :subject, :presence => true 
  validates :rubytype, :presence => true
  validates :tip, :length => {:minimum => 18}, :presence => true
  validates :xmail, :numericality => true, :allow_nil => true
  validates_length_of :xmail, :is => 6, :allow_nil => true
  validates :email, :presence => true, allow_nil: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  #    /^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Z‌​a-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$/i 
  validates :posted, :presence => true
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
