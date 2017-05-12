module Paper
  module Admin
    module LabelHelper

      def label_active(object)
        case object
        when TrueClass
          text_to_label :active
        when FalseClass
          text_to_label :deactive
        when ActiveRecord::Base
          if object.try(:active)
            text_to_label :active
          else
            text_to_label :deactive
          end
        else
          text_to_label :null
        end
      end

      def label_status(object)
        case object
        when String, Symbol
          text_to_label object
        when ActiveRecord::Base
          text_to_label object.try(:status)
        else
          text_to_label :null
        end
      end

      private

      def text_to_label(text)
        colors = {
          null: :default,
          waiting: :default,
          approved: :success,
          rejected: :danger,
          check_in: :success,
          confirmed: :success,
          active: :success,
          deactive: :warning
        }
        name = colors[text.to_sym] || :default
        content_tag :span, text, class: ["label", "label-#{name}"]
      end

    end
  end
end
