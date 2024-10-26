require 'action_view'
require 'form_builder/tailwind/version'
require 'form_builder/tailwind/tailwind'

module FormBuilder
  module Tailwind
    # Additional setup or configuration can go here if needed in the future.
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
