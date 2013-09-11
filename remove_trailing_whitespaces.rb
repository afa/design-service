patterns = ["app/**/*.rb", "app/**/*.js.coffee", "app/**/*.css.scss", "app/**/*.html.haml"]
patterns.map{|pat| Dir.glob(pat) }.flatten.each do |filename|
  content = File.readlines(filename).map{|line| line.rstrip}.join("\n") + "\n"
  File.write(filename, content)
end
