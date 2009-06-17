class XapitChange < ActiveRecord::Base
  serialize :index_attributes
  after_create :call_after_record_change
  
  def index_blueprint
    Marshal.load(index_blueprint_data) if index_blueprint_data
  end
  
  def index_blueprint=(blueprint)
    self.index_blueprint_data = Marshal.dump(blueprint)
  end
  
  def call_after_record_change
    XapitSync.call_after_record_change(self)
  end
end
