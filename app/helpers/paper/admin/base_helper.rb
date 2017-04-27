require "erb"

module Paper
  module Admin
    module BaseHelper

      def pa_render_template(name, options)
        render partial: "paper/admin/templates/#{name}", locals: options
      end

    end
  end
end
