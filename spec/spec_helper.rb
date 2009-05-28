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
  include Xapit::Membership # temporary until xapit gem properly does this
  xapit do |index|
    index.text :name
    index.field :name
    index.facet :name
  end
  include XapitSync::Membership # TODO this should happen automatically in xapit
end

Spec::Runner.configure do |config|
  config.mock_with :rr
end