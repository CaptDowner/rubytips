# config/initializers/scoped.rb
class ActiveRecord::Base
  # do things the modern way and silence Rails 4 deprecation warnings
  def self.scoped(options=nil)
    options ? where(nil).apply_finder_options(options, true) : where(nil)
  end
end
