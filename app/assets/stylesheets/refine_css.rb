filename = ARGV.first
lines = File.read(filename)

lines.gsub!(/^[ \t]+/, '')
lines.gsub!(/[ \t]+$/, '')

lines.gsub!(/[\t ]+/, ' ')
lines.gsub!(/([^; ])\s*\}/, '\1;}')
lines.gsub!(/;/, ";\n")
lines.gsub!(/\{/, "{\n")

lines.gsub!(/^[ \t]+/, '')
lines.gsub!(/[ \t]+$/, '')

lines.gsub!(/^(.+)\s*:\s*([^\{\}\n]+)$/, '\1: \2')
lines.gsub!(/\s*\{/, ' {')

puts lines