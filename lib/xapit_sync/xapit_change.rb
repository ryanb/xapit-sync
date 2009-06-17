class XapitChange < ActiveRecord::Base
  after_create :call_after_record_change
  
  def call_after_record_change
    XapitSync.call_after_record_change(self)
  end
end
