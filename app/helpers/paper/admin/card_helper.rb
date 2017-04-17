module Paper
  module Admin
    module CardHelper

      def pa_card(options={})
        options = {
          icon: :close,
          value: "Not set",
          label: "Not set",
          footer_icon: :close,
          footer_text: "Not set",
          color: :info
        }.merge(options)

        pa_render_template(:card, options)
      end

      def pa_success_card(options={})
        options[:color] = :success
        pa_card(options)
      end

      def pa_danger_card(options={})
        options[:color] = :danger
        pa_card(options)
      end

      def pa_primary_card(options={})
        options[:color] = :primary
        pa_card(options)
      end

      def pa_warning_card(options={})
        options[:color] = :warning
        pa_card(options)
      end

      def pa_info_card(options={})
        options[:color] = :info
        pa_card(options)
      end

    end
  end
end
