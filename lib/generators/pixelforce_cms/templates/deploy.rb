require 'bundler/capistrano'
set :rvm_ruby_string, '1.9.3'
require "rvm/capistrano"

set :application, '<%= application_name %>'
set :repository,  'git@bisplug.com:<%= application_name %>.git'
set :scm, :git

set :deploy_to,   '/home/deploy/<%= application_name %>'
set :user,        'deploy'
set :branch,      'master'
set :rails_env,   'production'
set :migrate_env, 'production'
set :use_sudo, false
set :deploy_via, :remote_cache

# server "<%= application_name %>.com.au", :app, :web, :db, :primary => true
server "119.9.13.249", :app, :web, :db, :primary => true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end  
  task :stop do ; end  
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd '/home/deploy/<%= application_name %>/current' ; bundle exec rake db:migrate db:seed RAILS_ENV=production"
    run "touch #{File.join('/home/deploy/<%= application_name %>/current','tmp','restart.txt')}"
  end
end