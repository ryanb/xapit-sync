require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe XapitChange do
  it "should trigger override_syncing callback upon creating" do
    @syncing = false
    XapitSync.override_syncing do
      @syncing = true
    end
    XapitChange.create!
    @syncing.should be_true
  end
end
