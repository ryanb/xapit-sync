$:.unshift(File.dirname(__FILE__))
require 'xapit_sync/membership'
require 'xapit_sync/xapit_change'
require 'xapit_sync/processor'

module XapitSync
  def self.after_record_change(&block)
    @after_record_change_proc = block
  end
  
  def self.call_after_record_change(change)
    if @after_record_change_proc
      @after_record_change_proc.call(change)
    else
      system("#{Rails.root}/script/runner -e #{Rails.env} 'XapitSync.sync(3.minutes)'")
    end
  end
  
  def self.reset_after_record_change
    @after_record_change_proc = nil
  end
  
  def self.sync(delay = 0)
    Processor.new.run(delay)
  end
end
