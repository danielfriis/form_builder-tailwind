module FormBuilder
  module Tailwind
    class Tailwind < ActionView::Helpers::FormBuilder
      TEXT_LIKE_FIELDS = %i[text_field text_area email_field password_field phone_field number_field].freeze

      TEXT_LIKE_FIELDS.each do |field_type|
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{field_type}(attribute, opts={})
            if opts.delete(:processed)
              super
            else
              text_like_field(__method__, attribute, opts)
            end
          end
        RUBY
      end

      def text_like_field(field_type, attribute, opts = {})
        default_class = "mt-1 block w-full px-3 py-2 rounded-md border-gray-200 focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
        error_class = "border-2 border-red-500" if @object&.is_a?(ActiveModel::Model) && @object&.errors&.any?

        default_opts = {class: "#{default_class} #{error_class}"}
        merged_opts = default_opts.merge(opts)

        @template.content_tag(:div, class: "mb-4") do
          field_content = send(field_type, attribute, merged_opts.merge(processed: true))

          label_text = opts[:label].nil? ? attribute.to_s.humanize : opts[:label]
          label_text = nil if opts[:label] == false
          label_text ? label(attribute, label_text) + field_content : field_content
        end
      end

      def check_box(attribute, opts = {})
        default_opts = {class: "h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-600"}
        merged_opts = default_opts.merge(opts)

        @template.content_tag :div, class: "flex gap-x-3 items-center mb-4" do
          super(attribute, merged_opts) + label(attribute, opts[:label])
        end
      end

      def select(attribute, choices, opts = {}, html_opts = {})
        default_class = "mt-1 block w-full px-3 py-2 pr-10 rounded-md border-gray-200 focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
        error_class = "border-2 border-red-500" if @object&.is_a?(ActiveModel::Model) && @object&.errors&.any?

        default_html_opts = {class: "#{default_class} #{error_class}"}
        merged_html_opts = default_html_opts.merge(html_opts)

        @template.content_tag(:div, class: "mb-4") do
          field_content = super(attribute, choices, opts, merged_html_opts)
          opts[:hide_label] ? field_content : label(attribute) + field_content
        end
      end

      def label(attribute, text = nil, opts = {})
        default_opts = {class: "block text-sm font-medium text-gray-700 mb-1"}
        merged_opts = default_opts.merge(opts)

        super(attribute, text, merged_opts)
      end

      def submit(value, opts = {})
        default_opts = {class: "cursor-pointer"}
        merged_opts = default_opts.merge(opts)

        super(value, merged_opts)
      end
    end
  end
end
