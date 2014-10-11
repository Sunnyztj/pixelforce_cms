namespace :delayed_job do
  desc "Setup delayed job"

  desc "Setup delayed configuration for this application"
  task :setup, roles: :web do
    template "delayed_job_init.erb", "/tmp/delayed"
    run "#{sudo} mv /tmp/delayed /etc/init.d/#{application}_delayed"
    run "#{sudo} chmod +x /etc/init.d/#{application}_delayed"
    run "#{sudo} update-rc.d #{application}_delayed defaults"
  end
  # after "deploy:setup", "nginx:setup"
  
  %w[start stop reindex].each do |command|
    desc "#{command} delayed"
    task command, roles: :web do
      run "/etc/init.d/#{application}_delayed #{command}"
    end
  end
end