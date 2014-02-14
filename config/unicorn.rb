worker_processes 4
timeout 15
preload_app true

after_fork do |server, worker|
  Redis.current.quit
end
