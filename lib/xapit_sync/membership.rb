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
    end
  end
end
