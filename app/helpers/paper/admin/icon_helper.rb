module Paper
  module Admin
    module IconHelper

      def ti_icon(code)
        content_tag :i, nil, class: "ti-#{code}"
      end

    end
  end
end
