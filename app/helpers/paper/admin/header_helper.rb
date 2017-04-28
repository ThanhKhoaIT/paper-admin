module Paper
  module Admin
    module HeaderHelper

      def pa_navbar(&block) #pa_header_action(link: "#", text: "Stats", icon: :panel, method: :patch)
        content_tag :div, class: 'navbar-collapse collapse' do
          content_tag :ul, class: "nav navbar-nav navbar-right" do
            yield(block)
          end
        end
      end

      def pa_header_action(options={})
        options = {
          icon: :close,
          text: "Not set",
          link: root_path,
          method: :get
        }.merge(options)

        content_tag :li do
          link_to options[:link], method: options[:method] do
            concat ti_icon(options[:icon])
            concat " "
            concat content_tag(:p, options[:text])
          end
        end
      end

    end
  end
end
