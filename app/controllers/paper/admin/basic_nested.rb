module Paper
  module Admin
    module BasicNested
      extend ActiveSupport::Concern

      included do
        before_action :default_find_object, only: [:show, :edit, :update, :destroy]
      end

      def index
        is_active_record_sources? do
          page_items = sources.all.page(params[:page])
          instance_variable_set("@#{sources_under_pluralize}", page_items)
        end
      end

      def new
        is_active_record_sources? do
          set_object(sources.new)
        end
      end

      def create
        is_active_record_sources? do
          set_object(sources.new(params_permited!))
          if get_object.save
            after_save if self.respond_to? :after_save
            flash[:notice] = "Create successful!"
            redirect_to action: :index
          else
            flash[:error] = "Create failure!"
            render action: :new
          end
        end
      end

      def show
      end

      def edit
      end

      def update
        is_active_record_sources? do
          if get_object.update(params_permited!)
            after_update if self.respond_to? :after_update
            flash[:notice] = "Update successful!"
            redirect_to action: :index
          else
            flash[:error] = "Update failure!"
            render :edit
          end
        end
      end

      def destroy
        is_active_record_sources? do
          if get_object.destroy
            flash[:notice] = "Remove successful!"
          else
            flash[:error] = "Remove failure!"
          end
          redirect_to action: :index
        end
      end

      private

      def find_object
        default_find_object
      end

      def default_find_object
        is_active_record_sources? do
          friendly_used = sources.respond_to? :friendly
          if friendly_used
            set_object(sources.friendly.find(params[:id]))
          else
            set_object(sources.find(params[:id]))
          end
        end
      end

      def sources
        raise NotImplementedError, "need to defined `sources` method in private area of controller #{params[:controller]}"
      end

      def get_object
        instance_variable_get("@#{sources_under_singularize}")
      end

      def set_object(obj)
        instance_variable_set("@#{sources_under_singularize}", obj)
      end

      def is_active_record_sources?
        yield if sources && sources.is_a?(ActiveRecord::Associations::CollectionProxy)
      end

      def sources_under_pluralize
        sources.model_name.name.underscore.pluralize.gsub(/\//, '_')
      end

      def sources_under_singularize
        sources.model_name.name.underscore.singularize.gsub(/\//, '_')
      end

      def params_permited!
        params[sources_under_singularize].permit!
      end

    end
  end
end
