$:.unshift(File.dirname(__FILE__))
require 'xapit_sync/membership'
require 'xapit_sync/xapit_change'
require 'xapit_sync/indexer'

module XapitSync
  def self.override_syncing(&block)
    @syncing_proc = block
  end
  
  def self.start_syncing
    if @syncing_proc
      @syncing_proc.call
    else
      system("#{Rails.root}/script/runner -e #{Rails.env} 'XapitSync.sync'")
    end
  end
  
  def self.reset_syncing
    @syncing_proc = nil
  end
  
  def self.sync(delay = 3.minutes)
    Indexer.new.run(delay)
  end
end
