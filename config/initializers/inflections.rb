# Be sure to restart your server when you modify this file.

ActiveSupport::Inflector.inflections do |inflect|
# Add new inflection rules using the following format
# (all these examples are active by default):
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )

  inflect.singular(/(ss)$/i, '\1') # makes 'address'.singlarize work properly
end
#
# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.acronym 'RESTful'
# end
