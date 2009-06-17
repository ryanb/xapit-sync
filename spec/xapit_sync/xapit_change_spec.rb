require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe XapitChange do
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
end
