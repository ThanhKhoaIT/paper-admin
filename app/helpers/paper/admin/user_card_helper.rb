module Paper
  module Admin
    module UserCardHelper

      def pa_user_card(options={})
        options = {
          avatar: 'http://placehold.it/300x300',
          cover: 'http://placehold.it/356x265',
          name: :name,
          username: :username,
          about: :about,
          fields: []
        }.merge(options)

        pa_render_template(:user_card, options)
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
