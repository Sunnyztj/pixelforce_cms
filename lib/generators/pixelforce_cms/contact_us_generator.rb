require 'rails/generators'

module PixelforceCms
  module Generators
    class ContactUsGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def create_model
        copy_file "contact_us.rb", "app/models/contact_us.rb"
        copy_file "contacts_controller.rb", "app/controllers/contacts_controller.rb"
        template  "notification.rb", 'app/mailers/notification.rb'
        create_file "app/views/notification/notify_us.text.haml"
        route_config = %q(
  get  '/contact', to: 'contacts#new', as: :conatct
  post '/contact', to: 'contacts#create'
        )
        inject_into_file 'config/routes.rb', "\n#{route_config}\n", { :after => '::Application.routes.draw do', :verbose => false }
      end

      def application_name
        if defined?(Rails) && Rails.application
          Rails.application.class.name.split('::').first.underscore
        else
          "application"
        end
      end
      
    end
  end
end
