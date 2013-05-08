namespace :guests do
  desc "Remove guest accounts more than a week old."
  task :cleanup => :environment do
    User.where(role: 'guest').where("created_at < ?", 1.weaks.ago).destroy_all
  end
end
