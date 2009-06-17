class XapitChange < ActiveRecord::Base
  after_create :start_syncing
  
  def self.record_change(target, operation)
    create!(:target_class => target.class.name, :target_id => target.id, :operation => operation)
  end
  
  def start_syncing
    unless XapitSync::Indexer.running?
      XapitSync.start_syncing
    end
  end
  
  def update_index
    target.class.xapit_index_blueprint.create_record(target)
  end
  
  def target
    @target ||= target_class.constantize.find(target_id)
  end
end
