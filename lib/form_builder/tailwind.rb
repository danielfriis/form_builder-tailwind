require "form_builder/tailwind/version"
require "form_builder/tailwind/configuration"
require "form_builder/tailwind/tailwind"

module FormBuilder
  module Tailwind
    class Error < StandardError; end

    # Ensure Tailwind is included in ActionView::Helpers::FormBuilder
    if defined?(ActionView::Helpers::FormBuilder)
      ActionView::Helpers::FormBuilder.include(self)
    end
  end
end
