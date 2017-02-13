if File.exist?(".pid")
  running_pid = File.read(".pid").to_i
  Process.kill("HUP", running_pid) rescue Errno::ESRCH
end

pid = Process.fork do
  load File.expand_path("../init.rb", __FILE__)
end

Process.detach(pid)

File.write(".pid", pid)
