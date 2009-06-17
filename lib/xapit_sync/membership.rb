module XapitSync
  module Membership
    def self.included(base)
      base.after_create do |record|
        XapitChange.create!(
          :target_class => record.class.name,
          :target_id => record.id,
          :operation => "create"
        )
      end
      
      # TODO some duplication with after_create callback
      base.after_update do |record|
        XapitChange.create!(
          :target_class => record.class.name,
          :target_id => record.id,
          :operation => "update"
        )
      end
      
      # TODO some duplication with after_create callback
      base.after_destroy do |record|
        XapitChange.create!(
          :target_class => record.class.name,
          :target_id => record.id,
          :operation => "destroy"
        )
      end
    end
  end
end
