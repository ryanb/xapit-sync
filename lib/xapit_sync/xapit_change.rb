class XapitChange < ActiveRecord::Base
  after_create :start_syncing
  
  def self.record_change(record, operation)
    create!(:target_class => record.class.name, :target_id => record.id, :operation => operation)
  end
  
  def start_syncing
    XapitSync.start_syncing
  end
end
