Dir.glob('./**/*.css.scss') do |filename|
  content = File.read(filename)

=begin
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
=end

  edited_content = content.
    gsub(/\t/,'  ').
    gsub(/ +$/,'').
    gsub(/ *\{/,' {').
    gsub(/([\w;]) *\}/,'\1 }').
    gsub(/ *: *([^{}\n]*)$/,': \1').
    gsub(/ +$/,'')

  File.write(filename, edited_content)
end