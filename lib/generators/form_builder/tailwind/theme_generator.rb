module FormBuilder
  module Tailwind
    module Generators
      class ThemeGenerator < Rails::Generators::Base
        source_root File.expand_path("templates", __dir__)

        def create_theme_file
          template "theme.rb", "config/initializers/form_builder_tailwind_theme.rb"
        end

        def show_readme
          readme "README" if behavior == :invoke
        end
      end
    end
  end
end 