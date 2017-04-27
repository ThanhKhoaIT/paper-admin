module Paper
  module Admin
    module TableHelper

      def pa_table(options={})
        table_render = ::Paper::Admin::Render::Table.new(options)
        content_tag :div, class: 'table-responsive table-full-width' do
          content_tag :table, class: "table table-striped" do
            concat table_render.header unless table_render.header_rendered?
            concat yield(table_render)
          end
        end
      end

      def pa_model_table(collection, options={})
        pa_table options do |t|
          yield t if block_given?
          collection.map do |item|
            t.row(item) do
              actions_cell(item)
            end
          end.join.html_safe
        end
      end

      private

      def actions_cell(item)
        object_name = item.class.name.underscore
        partial_action_file = "paper/admin/actions/#{object_name}"
        render(partial_action_file, { object_name => item }.symbolize_keys)
      end

    end
  end
end
