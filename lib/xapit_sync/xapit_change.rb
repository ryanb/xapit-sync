class XapitChange < ActiveRecord::Base
  serialize :index_attributes
  
  def index_blueprint
    Marshal.load(index_blueprint_data) if index_blueprint_data
  end
  
  def index_blueprint=(blueprint)
    self.index_blueprint_data = Marshal.dump(blueprint)
  end
end
