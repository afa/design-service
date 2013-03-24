module ActionView
  module Helpers
    module TranslationHelper
      private
      def html_safe_translation_key?(key)
        true
      end
    end
  end
end

# make inputs html-safe in order to use radio-buttons in form: "<input...><label><label/>"
module SimpleForm
  module Inputs
    class CollectionInput < Base
      reset_i18n_cache :boolean_collection
      def self.boolean_collection
        i18n_cache :boolean_collection do
          [ [I18n.t(:"simple_form.yes", :default => 'Yes').html_safe, true],
            [I18n.t(:"simple_form.no", :default => 'No').html_safe, false] ]
        end
      end 
    end
  end
end
