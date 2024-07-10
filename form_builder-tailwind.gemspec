# frozen_string_literal: true

require_relative "lib/form_builder/tailwind/version"

Gem::Specification.new do |s|
  s.name        = 'form_builder-tailwind'
  s.version     = FormBuilder::Tailwind::VERSION
  s.summary     = "Tailwind CSS form builder for Rails"
  s.description = "A custom form builder for Rails that generates Tailwind CSS styled form elements"
  s.authors     = ["Daniel Friis"]
  s.email       = 'd@friis.me'
  s.files       = Dir['lib/**/*']
  s.homepage    = 'https://github.com/danielfriis/form_builder-tailwind'
  s.license     = 'MIT'

  s.add_dependency 'actionview', '>= 5.0'
end
