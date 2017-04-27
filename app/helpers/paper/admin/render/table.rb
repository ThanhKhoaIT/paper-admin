module Paper
  module Admin
    module Render
      class Table
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper

        def initialize(options)
          default_options = {
            columns: [:id, :created_at, :updated_at],
            actions: false
          }
          @options = default_options.merge(options)
          if options[:headers].blank?
            @options[:headers] = @options[:columns].map(&:to_s).map(&:titleize)
          end
          @header_rendered = false
        end

        def header
          @header_rendered = true
          content_tag(:thead) do
            content_tag :tr do
              options[:headers].map do |header|
                concat content_tag(:th, header)
              end
              if options[:actions]
                if options[:actions].is_a?(String)
                  concat content_tag(:th, options[:actions])
                else
                  concat content_tag(:th, "Actions")
                end
              end
            end
          end
        end

        def row(*args)
          columns = args
          is_active_record = false
          if args.size == 1 && args.first.is_a?(ActiveRecord::Base)
            columns = values_of_object(args.first)
            is_active_record = true
          end

          content_tag :tr do
            columns.each do |column|
              concat content_tag(:td, column)
            end
            if options[:actions] && is_active_record && block_given?
              concat content_tag(:td, yield)
            end
          end
        end

        def rows(collection, keys: [])
          collection.map do |item|
            row(*values_by_keys(item, keys))
          end.join.html_safe
        end

        def values_by_keys(item, keys)
          keys.map { |k| item.respond_to?(k) ? item.public_send(k) : nil }
        end

        def header_rendered?
          header_rendered
        end

        private
        attr_reader :options, :header_rendered

        def values_of_object(object)
          options[:columns].map do |column|
            object.respond_to?(column) ? object.public_send(column) : nil
          end
        end

      end
    end
  end
end
