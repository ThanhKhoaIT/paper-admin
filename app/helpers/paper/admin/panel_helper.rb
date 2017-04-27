module Paper
  module Admin
    module PanelHelper

      def pa_panel(options={})
        block = -> (rendor){ yield(rendor)}
        Paper::Admin::Render::Panel.new(options, block).render
      end

    end
  end
end
