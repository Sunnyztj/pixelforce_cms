require 'rails/generators'

module PixelforceCms
  module Generators
    class ControllerGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      argument :controller_name, type: :string

      def create_controller
        template "base_controller.rb", "app/controllers/admin/base_controller.rb"
        template "admin_controller.rb", "app/controllers/admin/#{file_name.pluralize}_controller.rb"
      end

      def create_views
        # template 'index.html.haml', "app/views/admin/#{file_name}/index.html.haml"
        template 'new.html.haml', "app/views/admin/#{file_name}/new.html.haml"
        template 'edit.html.haml', "app/views/admin/#{file_name}/edit.html.haml"
        template '_form.html.haml', "app/views/admin/#{file_name}/_form.html.haml"
      end

      def create_route
        sentinel = "authenticated :user do\n"
        routing_code = "resources :#{file_name.pluralize}, controller: 'admin/#{file_name.pluralize}'"
        in_root do
          inject_into_file 'config/routes.rb', "    #{routing_code}\n", { :after => sentinel, :verbose => false }
        end
      end

      private

      def file_name
        controller_name.pluralize.underscore
      end
    end
  end
end