module XapitSync
  module Membership
    def self.included(base)
      base.after_create do |record|
        XapitChange.record_change(record, "create")
      end
      
      base.after_update do |record|
        XapitChange.record_change(record, "update")
      end
      
      base.after_destroy do |record|
        XapitChange.record_change(record, "destroy")
      end
    end
  end
end
