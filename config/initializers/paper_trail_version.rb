class Version < ActiveRecord::Base
  if defined?(Rails::Console)
    #PaperTrail.whodunnit = "#{`whoami`.strip}: console"
    PaperTrail.whodunnit = "#{'Anonymous'}: console"
  elsif File.basename($0) == "rake"
    #PaperTrail.whodunnit = "#{`whoami`.strip}: rake #{ARGV.join ' '}"
    PaperTrail.whodunnit = "#{'Anonymous'}: rake #{ARGV.join ' '}"
  end

end
