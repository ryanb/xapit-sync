require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Recipe do
  it "should make xapit change when created" do
    XapitChange.delete_all
    recipe = Recipe.create!(:name => "foo")
    change = XapitChange.first
    change.target_class.should == "Recipe"
    change.target_id.should == recipe.id
    change.operation.should == "create"
  end
end
