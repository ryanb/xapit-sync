$:.unshift(File.dirname(__FILE__))
require 'xapit_sync/membership'
require 'xapit_sync/xapit_change'

module XapitSync
  def self.after_record_change(&block)
    @after_record_change_proc = block
  end
  
  def self.call_after_record_change(change)
    @after_record_change_proc.call(change) if @after_record_change_proc
  end
end
