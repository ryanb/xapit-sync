module XapitSync
  class Indexer
    def run(delay)
      raise "XapitSync is already running (xapit_sync.pid file exists)." if self.class.running?
      File.open("/pid/path", "w") { |f| f.puts Process.pid }
      index_changes(delay)
      File.delete("/pid/path")
    end
    
    def self.pid_path
      "#{Rails.root}/tmp/xapit_sync.pid"
    end
    
    def self.running?
      File.exist? pid_path
    end
    
    def index_changes(delay)
      while change = XapitChange.first
        change.update_index
        change.destroy
      end
    end
  end
end
