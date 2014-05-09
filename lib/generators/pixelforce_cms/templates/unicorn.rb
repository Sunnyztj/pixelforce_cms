rails_env = ENV['RACK_ENV'] || 'production'
worker_processes 2
working_directory '/home/deploy/<%= @application_name %>/current'

listen '/tmp/<%= @application_name %>.sock', :backlog => 2048
listen 5001, :tcp_nopush => true

timeout 60
pid "/home/deploy/<%= @application_name %>/shared/pids/unicorn.pid"
preload_app  true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

stderr_path '/home/deploy/<%= @application_name %>/shared/log/<%= @application_name %>.log'

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
     Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end