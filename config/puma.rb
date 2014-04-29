workers Integer(ENV['PUMA_WORKERS'] || 2)

threads Integer(ENV['PUMA_MIN_THREADS'] || 16),
        Integer(ENV['PUMA_MAX_THREADS'] || 16)

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 9292
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # worker specific setup
end
