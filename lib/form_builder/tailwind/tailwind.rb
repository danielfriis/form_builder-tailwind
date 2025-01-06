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
        error_class = theme.field_error_classes if @object&.is_a?(ActiveModel::Model) && @object&.errors&.any?

        default_opts = {class: [theme.text_field_classes, error_class].compact.join(" ")}
        merged_opts = default_opts.merge(opts)

        @template.content_tag(:div, class: theme.field_wrapper_classes) do
          field_content = send(field_type, attribute, merged_opts.merge(processed: true))

          label_text = opts[:label].nil? ? attribute.to_s.humanize : opts[:label]
          label_text = nil if opts[:label] == false
          label_text ? label(attribute, label_text) + field_content : field_content
        end
      end

      def check_box(attribute, opts = {})
        default_opts = {class: theme.checkbox_classes}
        merged_opts = default_opts.merge(opts)

        @template.content_tag :div, class: theme.checkbox_wrapper_classes do
          super(attribute, merged_opts) + label(attribute, opts[:label])
        end
      end

      def select(attribute, choices, opts = {}, html_opts = {})
        error_class = theme.field_error_classes if @object&.is_a?(ActiveModel::Model) && @object&.errors&.any?

        default_html_opts = {class: [theme.select_field_classes, error_class].compact.join(" ")}
        merged_html_opts = default_html_opts.merge(html_opts)

        @template.content_tag(:div, class: theme.field_wrapper_classes) do
          field_content = super(attribute, choices, opts, merged_html_opts)
          opts[:hide_label] ? field_content : label(attribute) + field_content
        end
      end

      def label(attribute, text = nil, opts = {})
        default_opts = {class: theme.label_classes}
        merged_opts = default_opts.merge(opts)

        super(attribute, text, merged_opts)
      end

      def submit(value, opts = {})
        default_opts = {class: theme.submit_button_classes}
        merged_opts = default_opts.merge(opts)

        super(value, merged_opts)
      end

      private

      def theme
        @theme ||= FormBuilder::Tailwind.configuration.theme
      end
    end
  end
end
