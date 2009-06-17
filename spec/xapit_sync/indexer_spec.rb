require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe XapitSync::Indexer do
  before(:each) do
    # we don't want to trigger the sync process with these
    XapitSync.override_syncing { }
  end
  
  it "should have path to pid file" do
    Rails = Class.new unless defined? Rails
    stub(Rails).root { "/rails/root" }
    XapitSync::Indexer.pid_path.should == "#{Rails.root}/tmp/xapit_sync.pid"
  end
  
  it "should consider running when pid file exists" do
    stub(XapitSync::Indexer).pid_path { "/pid/path" }
    mock(File).exist?("/pid/path") { true }
    XapitSync::Indexer.should be_running
  end
  
  it "should consider running when pid file exists" do
    stub(XapitSync::Indexer).pid_path { "/pid/path" }
    mock(File).exist?("/pid/path") { true }
    XapitSync::Indexer.should be_running
  end
end
