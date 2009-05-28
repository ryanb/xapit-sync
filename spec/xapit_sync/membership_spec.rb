require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Recipe do
  it "should make xapit change when created" do
    XapitChange.delete_all
    Recipe.create!(:name => "foo")
    XapitChange.first.target_class == "Recipe"
  end
end
