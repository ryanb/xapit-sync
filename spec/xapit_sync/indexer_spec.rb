require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe XapitSync::Indexer do
  before(:each) do
    # we don't want to trigger the sync process with these
    XapitSync.override_syncing { }
  end
  
  it "should have path to pid file" do
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
  
  it "should raise an exception when attempting to run when already running" do
    stub(XapitSync::Indexer).running? true
    lambda { XapitSync::Indexer.new.run(0) }.should raise_error
  end
  
  it "should create and delete pid file when run" do
    stub(XapitSync::Indexer).pid_path { "/pid/path" }
    indexer = XapitSync::Indexer.new
    mock(File).open("/pid/path", "w")
    mock(indexer).index_changes(123)
    mock(File).delete("/pid/path")
    indexer.run(123)
  end
  
  it "should loop through all changes and index each of them" do
    XapitChange.delete_all
    recipe = Recipe.create!(:name => "foo")
    mock(Recipe.xapit_index_blueprint).create_record(recipe.id)
    indexer = XapitSync::Indexer.new
    mock(indexer).sleep(5)
    mock(indexer).push_changes
    indexer.index_changes(5)
    XapitChange.count.should == 0
  end
  
  it "should push changes by flushing the database and reloading domains" do
    mock(Xapit::Config).writable_database.stub!.flush
    mock(XapitSync).reload_domains
    indexer = XapitSync::Indexer.new
    indexer.push_changes
  end
end
