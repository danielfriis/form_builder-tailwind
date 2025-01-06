FormBuilder::Tailwind.configure do |config|
  config.theme = Class.new do
    def text_field_classes
      "mt-1 block w-full px-3 py-2 rounded-md border-gray-200 focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
    end

    def field_error_classes
      "border-2 border-red-500"
    end

    def field_wrapper_classes
      "mb-4"
    end

    def checkbox_classes
      "h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-600"
    end

    def checkbox_wrapper_classes
      "flex gap-x-3 items-center mb-4"
    end

    def select_field_classes
      "mt-1 block w-full px-3 py-2 pr-10 rounded-md border-gray-200 focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
    end

    def label_classes
      "block text-sm font-medium text-gray-700 mb-1"
    end

    def submit_button_classes
      "cursor-pointer"
    end
  end.new
end 