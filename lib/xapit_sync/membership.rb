module XapitSync
  module Membership
    def self.included(base)
      base.after_create do |record|
        XapitChange.create!(
          :target_class => record.class.name,
          :target_id => record.id,
          :operation => "create",
          :index_attributes => record.xapit_index_attributes,
          :index_blueprint => record.class.xapit_index_blueprint
        )
      end
      
      # TODO some duplication with after_create callback
      base.after_update do |record|
        XapitChange.create!(
          :target_class => record.class.name,
          :target_id => record.id,
          :operation => "update",
          :index_attributes => record.xapit_index_attributes,
          :index_blueprint => record.class.xapit_index_blueprint
        )
      end
    end
    
    def xapit_index_attributes
      bp = self.class.xapit_index_blueprint
      attribute_names = [:id] + bp.text_attributes.keys + bp.field_attributes + bp.sortable_attributes + bp.facets.map(&:attribute)
      attribute_names.uniq.inject({}) do |hash, name|
        hash[name.to_sym] = send(name)
        hash
      end
    end
  end
end
