require 'action_view'
require 'form_builder/tailwind/version'
require 'form_builder/tailwind/tailwind'

module FormBuilder
  module Tailwind
    class ConfigurationChecker
      def self.check_tailwind_config
        return unless defined?(Rails) && Rails.env.development?
        
        tailwind_config_path = Rails.root.join('tailwind.config.js')
        
        unless File.exist?(tailwind_config_path)
          warn "[FormBuilder::Tailwind] Warning: tailwind.config.js not found"
          return
        end

        config_content = File.read(tailwind_config_path)
        gem_path_pattern = 'vendor/bundle/ruby/*/gems/form_builder-tailwind-*'
        
        unless config_content.include?(gem_path_pattern)
          warn "[FormBuilder::Tailwind] Warning: Tailwind configuration may not include gem's styles."
          warn "Please add the following to your content array in tailwind.config.js:"
          warn "\nmodule.exports = {"
          warn "  content: ["
          warn "    './#{gem_path_pattern}/lib/**/*.{rb,erb,html}'"
          warn "  ]"
          warn "}"
        end
      end
    end

    # Run the check when the module is included
    if defined?(Rails)
      Rails.application.config.to_prepare do
        ConfigurationChecker.check_tailwind_config
      end
    end
  end
end

# Reopen ActionView::Helpers::FormBuilder and include the Tailwind module
module ActionView
  module Helpers
    class FormBuilder
      include ::FormBuilder::Tailwind
    end
  end
end
