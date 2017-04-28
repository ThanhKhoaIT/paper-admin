module Paper
  module Admin
    module IconHelper

      def ti_icon(code)
        icon_code = code.to_s.gsub('_', '-')
        content_tag :i, nil, class: "ti-#{icon_code}"
      end

    end
  end
end
