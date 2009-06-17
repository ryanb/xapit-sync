require 'rubygems'
require 'spec'
require 'active_support'
require 'active_record'
require 'xapit' # gem install xapit

# setup database adapter
ActiveRecord::Base.establish_connection({
  :adapter => "sqlite3",
  :dbfile => File.dirname(__FILE__) + "/test.sqlite3"
})

load File.dirname(__FILE__) + '/schema.rb' unless File.exist?(File.dirname(__FILE__) + "/test.sqlite3")

require File.dirname(__FILE__) + '/../lib/xapit_sync'

class Recipe < ActiveRecord::Base
  xapit do |index|
    index.text :name
    index.field :name
    index.facet :name
    index.sortable :name
  end
  include XapitSync::Membership # TODO this should happen automatically in xapit
end

# Stub out needed Rails methods since we aren't loading the entire Rails environment here
class Rails
  def self.root
    "/rails/root"
  end
  
  def self.env
    "test"
  end
end

Spec::Runner.configure do |config|
  config.mock_with :rr
end
