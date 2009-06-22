module XapitSync
  class Indexer
    def run(delay)
      raise "XapitSync is already running (xapit_sync.pid file exists)." if self.class.running?
      begin
        File.open(self.class.pid_path, "w") { |f| f.puts Process.pid }
        index_changes(delay)
      ensure
        File.delete(self.class.pid_path)
      end
    end
    
    def self.pid_path
      "#{Rails.root}/tmp/xapit_sync.pid"
    end
    
    def self.running?
      File.exist? pid_path
    end
    
    def index_changes(delay)
      while XapitChange.count > 0
        XapitChange.all.each do |change|
          change.update_index
          change.destroy
        end
        if XapitChange.count.zero?
          push_changes
          sleep delay.to_f
        end
      end
    end
    
    def push_changes
      Xapit::Config.writable_database.flush
      XapitSync.reload_domains
    end
  end
end
