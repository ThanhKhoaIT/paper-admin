module Paper
  module Admin
    module SidebarHelper

      def pa_sidebar_item(options={})
        options = {
          icon: :close,
          text: "Not set",
          link: root_path,
          active: {}
        }.merge(options)

        if options[:active].is_a?(TrueClass)
          class_name = :active
        elsif options[:active].is_a?(FalseClass)
          class_name = nil
        elsif current_page?(options[:active])
          class_name = :active
        else
          class_name = nil
        end
        content_tag :li, class: class_name do
          link_to options[:link] do
            concat ti_icon(options[:icon])
            concat content_tag(:p, options[:text])
          end
        end
      end

    end
  end
end
