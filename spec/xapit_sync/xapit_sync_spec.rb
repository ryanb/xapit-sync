require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe XapitSync do
  before(:each) do
    XapitSync.reset_syncing
  end
  
  it "should trigger XapitSync.sync through script/runner" do
    Rails = Class.new unless defined? Rails
    stub(Rails).root { "/rails/root" }
    stub(Rails).env { "foobar" }
    mock(XapitSync).system("#{Rails.root}/script/runner -e foobar 'XapitSync.sync(3.minutes)'")
    XapitSync.start_syncing
  end
end
