require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe XapitChange do
  before(:each) do
    # we don't want to trigger the sync process with these
    XapitSync.override_syncing { }
  end
  
  it "should trigger override_syncing callback upon creating" do
    @syncing = false
    XapitSync.override_syncing { @syncing = true }
    XapitChange.create!
    @syncing.should be_true
  end
  
  it "should not start syncing if indexer is running" do
    stub(XapitSync::Indexer).running? { true }
    @syncing = false
    XapitSync.override_syncing { @syncing = true }
    XapitChange.create!
    @syncing.should be_false
  end
  
  it "should fetch target from class/id" do
    XapitChange.delete_all
    recipe = Recipe.create!
    XapitChange.first.target.should == recipe
  end
  
  it "should call create_record on index blueprint with create operator" do
    XapitChange.delete_all
    recipe = Recipe.create!
    mock(Recipe.xapit_index_blueprint).create_record(recipe.id)
    XapitChange.first.update_index
  end
  
  it "should call update_record on index blueprint with update operator" do
    recipe = Recipe.create!
    XapitChange.delete_all
    recipe.update_attribute(:name, "Foo")
    mock(Recipe.xapit_index_blueprint).update_record(recipe.id)
    XapitChange.first.update_index
  end
  
  it "should call destroy_record on index blueprint with destroy operator" do
    recipe = Recipe.create!
    XapitChange.delete_all
    recipe.destroy
    mock(Recipe.xapit_index_blueprint).destroy_record(recipe.id)
    XapitChange.first.update_index
  end
end
