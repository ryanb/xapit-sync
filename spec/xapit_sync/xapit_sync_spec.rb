require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe XapitSync do
  before(:each) do
    XapitSync.reset_after_record_change
  end
  
  it "should trigger xapitsync command" do
    Rails = Class.new
    stub(Rails).root { "/rails/root" }
    stub(Rails).env { "foobar" }
    mock(XapitSync).system("#{Rails.root}/script/runner -e foobar 'XapitSync.sync(3.minutes)'")
    XapitSync.call_after_record_change(nil)
  end
end
