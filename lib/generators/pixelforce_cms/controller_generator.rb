require 'rails/generators'

module PixelforceCms
  module Generators
    class ControllerGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      argument :controller_name, type: :string

      def create_controller
        template "base_controller.rb", "app/controller/admin/base_controller.rb"
        template "admin_controller.rb", "app/controller/admin/#{file_name.pluralize}_controller.rb"
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
        controller_name.underscore
      end
    end
  end
end