timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")
path = "db/migrate/#{timestamp}_create_xapit_changes.rb"
puts "Generating #{path}"
File.open("#{Rails.root}/#{path}", "w") do |file|
  file.print <<-EOS
class CreateXapitChanges < ActiveRecord::Migration
  def self.up
    create_table "xapit_changes" do |t|
      t.string "target_class"
      t.integer "target_id"
      t.string "operation"
    end
  end
  
  def self.down
    drop_table "xapit_changes"
  end
end
EOS
end
puts "Now run `rake db:migrate`"
