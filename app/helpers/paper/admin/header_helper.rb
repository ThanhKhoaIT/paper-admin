module Paper
  module Admin
    module HeaderHelper

      def pa_navbar(&block)
        content_tag :ul, class: "nav navbar-nav navbar-right" do
          yield(block)
        end
      end

      def pa_header_action(options={})
        options = {
          icon: :close,
          text: "Not set",
          link: root_path
        }.merge(options)

        content_tag :li do
          link_to options[:link] do
            concat ti_icon(options[:icon])
            concat " "
            concat content_tag(:p, options[:text])
          end
        end
      end

    end
  end
end
