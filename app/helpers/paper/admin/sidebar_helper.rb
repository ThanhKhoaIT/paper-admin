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

        class_name = current_page?(options[:active]) ? :active : nil
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
