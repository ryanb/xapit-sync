require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe XapitChange do
  it "should trigger after_record_change callback upon creating" do
    @change_id = nil
    XapitSync.after_record_change do |change|
      @change_id = change.target_id
    end
    XapitChange.create!(:target_id => 123)
    @change_id.should == 123
  end
end
