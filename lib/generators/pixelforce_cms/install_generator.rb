require 'rails/generators'

module PixelforceCms
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def copy_assets
        copy_file "javascripts/application.js", "app/assets/javascripts/application.js"
        copy_file "javascripts/jasny-bootstrap.js", "vendor/assets/javascripts/jasny-bootstrap.js"
        copy_file "css/application.css", "app/assets/stylesheets/application.css"
        copy_file "css/_variables.css.scss", "vendor/assets/stylesheets/_variables.css.scss"
        copy_file "css/jasny-bootstrap-responsive.css", 'vendor/assets/stylesheets/jasny-bootstrap-responsive.css'
        copy_file "css/jasny-bootstrap.css", 'vendor/assets/stylesheets/jasny-bootstrap.css'
        copy_file "css/style.css.scss", 'vendor/assets/stylesheets/style.css.scss'
        copy_file "css/style.responsive.css.scss", 'vendor/assets/stylesheets/style.responsive.css.scss'
        copy_file "css/application/chromeframe.css.scss", 'vendor/assets/stylesheets/application/chromeframe.css.scss'
        copy_file "css/application/html5.css.scss", 'vendor/assets/stylesheets/application/html5.css.scss'
      end

      def copy_gemfile
        copy_file "Gemfile", 'Gemfile'
      end

      def copy_controller_files
        copy_file "application.html.haml", 'app/views/layouts/application.html.haml'
        create_file 'app/views/pages/index.html.haml'
        in_root do
          inject_into_file 'config/routes.rb', "\n  root :to => 'pages#index'\n", { :after => 'do', :verbose => false }
        end
      end

      def config_application
        email_config = %q(
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address => "smtp.gmail.com",
      :port => 587,
      :user_name => "pfmedia.ben@gmail.com",
      :password => "plus5261",
      :authentication => :plain
    })
        sentinel = "config.assets.version = '1.0'"
        inject_into_file 'config/application.rb', "\n#{email_config}\n", { :after => sentinel, :verbose => false }
      end
      
    end
  end
end
