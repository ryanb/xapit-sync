module XapitSync
  class Indexer
    def run(delay)
      
    end
    
    def self.pid_path
      "#{Rails.root}/tmp/xapit_sync.pid"
    end
    
    def self.running?
      File.exist? pid_path
    end
  end
end
