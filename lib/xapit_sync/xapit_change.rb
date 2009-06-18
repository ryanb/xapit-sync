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
    blueprint = target_class.constantize.xapit_index_blueprint
    case operation
    when "create" then blueprint.create_record(target_id)
    when "update" then blueprint.update_record(target_id)
    when "destroy" then blueprint.destroy_record(target_id)
    end
  end
  
  def target
    @target ||= target_class.constantize.find(target_id)
  end
end
