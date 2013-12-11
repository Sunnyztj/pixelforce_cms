namespace :unicorn do
  desc "Install unicorn"

  desc "Setup unicorn configuration for this application"
  task :setup, roles: :web do
    template "unicorn_init.erb", "/tmp/unicorn"
    run "#{sudo} mv /tmp/unicorn /etc/init.d/#{application}"
    run "#{sudo} chmod +x /etc/init.d/#{application}"
    run "#{sudo} update-rc.d #{application} defaults"
    template "nginx_config.erb", "/tmp/nginx_config"
    run "#{sudo} mv /tmp/nginx_config /etc/nginx/sites-enabled/#{application}"
    run "#{sudo} rm -f /etc/nginx/sites-enabled/default"
  end
  # after "deploy:setup", "nginx:setup"
  
  %w[start stop restart].each do |command|
    desc "#{command} unicorn"
    task command, roles: :web do
      run "#{sudo} service #{application} #{command}"
    end
  end
end