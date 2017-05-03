module Paper
  module Admin
    module Basic
      extend ActiveSupport::Concern

      included do
        before_action :default_find_object, only: [:show, :edit, :update, :destroy]
      end

      def index
        is_active_record_klass? do
          page_items = klass.all.page(params[:page])
          instance_variable_set("@#{klass_under_pluralize}", page_items)
        end
      end

      def new
        is_active_record_klass? do
          set_object(klass.new)
        end
      end

      def create
        is_active_record_klass? do
          set_object(klass.new(params_permited!))
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

      def edit
      end

      def update
        is_active_record_klass? do
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
        is_active_record_klass? do
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
        is_active_record_klass? do
          friendly_used = klass.respond_to? :friendly
          if friendly_used
            set_object(klass.friendly.find(params[:id]))
          else
            set_object(klass.find(params[:id]))
          end
        end
      end

      def klass
        params[:controller].remove("admin/").camelcase.singularize.constantize
      end

      def get_object
        instance_variable_get("@#{klass_under_singularize}")
      end

      def set_object(obj)
        instance_variable_set("@#{klass_under_singularize}", obj)
      end

      def is_active_record_klass?
        yield if klass && klass.new.is_a?(ActiveRecord::Base)
      end

      def klass_under_pluralize
        klass.name.underscore.pluralize
      end

      def klass_under_singularize
        klass.name.underscore.singularize
      end

      def params_permited!
        params[klass_under_singularize].permit!
      end

    end
  end
end
