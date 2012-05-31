require 'rubygems'

Gem.path.push "/home/sdownie/.rvm/gems/ruby-1.9.3-head@rails3"
Gem::Specification.find_by_name('bundler').activate

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
