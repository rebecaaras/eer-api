threads_count = ENV.fetch("RAILS_MAX_THREADS", 3)
threads threads_count, threads_count

bind "unix:///home/rebeca/deploy/eer-api/tmp/sockets/puma.sock"
environment ENV.fetch("RAILS_ENV")
preload_app!

plugin :tmp_restart

plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]

pidfile ENV["PIDFILE"] if ENV["PIDFILE"]
