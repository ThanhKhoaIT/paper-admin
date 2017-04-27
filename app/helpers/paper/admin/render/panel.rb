module Paper
  module Admin
    module Render
      class Panel
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper

        def initialize(options, block)
          @content_block = block
          load_default_options(options)
        end

        def render
          content_tag :div, class: :card do
            concat header_render
            concat content_render
          end
        end

        def header_right(&block)
        end

        private
        attr_reader :options, :content_block

        def load_default_options(options)
          @options = {
            title: nil,
            sub_title: nil,
          }.merge(options)
        end

        def content_render
          content_tag :div, content_block.call(self), class: :content
        end

        def header_render
          if [options[:title], options[:sub_title]].any?(&:present?)
            content_tag :div, class: :header do
              concat content_tag(:h4, options[:title], class: :title)
              concat content_tag(:p, options[:sub_title], class: :category)
            end
          end
        end

      end
    end
  end
end
