class XapitChange < ActiveRecord::Base
  after_create :call_after_record_change
  
  def self.record_change(record, operation)
    create!(:target_class => record.class.name, :target_id => record.id, :operation => operation)
  end
  
  def call_after_record_change
    XapitSync.call_after_record_change(self)
  end
end
