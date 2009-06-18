module XapitSync
  class Indexer
    def run(delay)
      raise "XapitSync is already running (xapit_sync.pid file exists)." if self.class.running?
      File.open(self.class.pid_path, "w") { |f| f.puts Process.pid }
      index_changes(delay)
      File.delete(self.class.pid_path)
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
        sleep delay if XapitChange.count.zero?
      end
      push_changes
    end
    
    def push_changes
      Xapit::Config.writable_database.flush
      XapitSync.reload_domains
    end
  end
end
