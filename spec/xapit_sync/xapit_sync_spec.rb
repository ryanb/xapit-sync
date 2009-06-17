require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe XapitSync do
  before(:each) do
    XapitSync.reset_syncing
  end
  
  it "should trigger XapitSync.sync through script/runner" do
    mock(XapitSync).system("#{Rails.root}/script/runner -e #{Rails.env} 'XapitSync.sync'")
    XapitSync.start_syncing
  end
end
