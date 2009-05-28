module XapitSync
  module Membership
    def self.included(base)
      base.after_save do |record|
        XapitChange.create!(:target_class => record.class.name)
      end
    end
  end
end
