require 'rails/generators'

module PixelforceCms
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      class_option :assets, :type => :boolean, :default => true, :description => "Include assets files" 
      class_option :controllers, :type => :boolean, :default => true, :description => "Include controller files" 
      class_option :config, :type => :boolean, :default => true, :description => "Include config files" 

      def copy_assets
        if options.assets?
          copy_file "javascripts/application.js", "app/assets/javascripts/application.js"
          copy_file "javascripts/respond.js", "vendor/assets/javascripts/respond.js"
          copy_file "css/style.css.scss", 'app/assets/stylesheets/style.css.scss'
          copy_file "css/style.responsive.css.scss", 'app/assets/stylesheets/style.responsive.css.scss'
          copy_file "css/application/application.css", "app/assets/stylesheets/application/application.css"
          copy_file "css/application/chromeframe.css.scss", 'app/assets/stylesheets/application/chromeframe.css.scss'
          copy_file "css/application/document.css.scss", 'app/assets/stylesheets/application/document.css.scss'
          copy_file "css/application/html5.css.scss", 'app/assets/stylesheets/application/html5.css.scss'
          copy_file "css/application/index.css.scss", 'app/assets/stylesheets/application/index.css.scss'
          copy_file "css/application/variables.css.scss", "app/assets/stylesheets/application/variables.css.scss"
          copy_file "css/pages/home.css.scss", "app/assets/stylesheets/pages/home.css.scss"
          remove_file "app/assets/stylesheets/application.css"
          create_file "app/assets/javascripts/layout.js"
        end
      end

      def copy_receipt        
        copy_file "recipes/base.rb", "config/recipes/base.rb"
        copy_file "recipes/unicorn.rb", "config/recipes/unicorn.rb"
        copy_file "recipes/sphinx.rb", "config/recipes/sphinx.rb"
        copy_file "recipes/templates/nginx_config.erb", "config/recipes/templates/nginx_config.erb"
        copy_file "recipes/templates/unicorn_init.erb", "config/recipes/templates/unicorn_init.erb"
        copy_file "recipes/templates/sphinx_init.erb", "config/recipes/templates/sphinx_init.erb"
      end

      def copy_controller_files
        if options.controllers?
          copy_file   "pages_controller.rb", 'app/controllers/pages_controller.rb'
          copy_file   "application.html.haml", 'app/views/layouts/application.html.haml'
          copy_file   "application/_chromeframe.html.haml", 'app/views/application/_chromeframe.html.haml'
          copy_file   "application/_footer.html.haml", 'app/views/application/_footer.html.haml'
          copy_file   "application/_head.html.haml", 'app/views/application/_head.html.haml'
          copy_file   "application/_header.html.haml", 'app/views/application/_header.html.haml'
          copy_file   'Capfile', 'Capfile'
          remove_file 'app/views/layouts/application.html.erb'
          create_file 'app/views/pages/index.html.haml'
          @application_name = application_name
          template    'deploy.rb', 'config/deploy.rb'
          template    'unicorn.rb', 'config/unicorn.rb'
        end
      end

      def config_application
        if options.config?
          copy_file "Gemfile", 'Gemfile'
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
