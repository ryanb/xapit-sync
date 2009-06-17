require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe XapitSync::Processor do
  before(:each) do
    # we don't want to trigger the xapitsync command with these
    XapitSync.after_record_change { }
  end
  
  it "should have path to pid file" do
    Rails = Class.new unless defined? Rails
    stub(Rails).root { "/rails/root" }
    XapitSync::Processor.pid_path.should == "#{Rails.root}/tmp/xapit_sync.pid"
  end
  
  it "should consider running when pid file exists" do
    stub(XapitSync::Processor).pid_path { "/pid/path" }
    mock(File).exist?("/pid/path") { true }
    XapitSync::Processor.should be_running
  end
end
