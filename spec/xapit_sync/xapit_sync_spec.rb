require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe XapitSync do
  before(:each) do
    XapitSync.reset_syncing
  end
  
  it "should trigger XapitSync.sync through script/runner" do
    mock(XapitSync).system("#{Rails.root}/script/runner -e #{Rails.env} 'XapitSync.sync'")
    XapitSync.start_syncing
  end
  
  it "should call open on each domain" do
    XapitSync.domains = ["localhost:8000", "localhost:8001"]
    mock(XapitSync).open("http://localhost:8000/xapit/reload")
    mock(XapitSync).open("http://localhost:8001/xapit/reload")
    XapitSync.reload_domains
  end
  
  it "should open localhost:3000 if no domains specified" do
    XapitSync.domains = nil
    XapitSync.domains.should == ["localhost:3000"]
  end
end
