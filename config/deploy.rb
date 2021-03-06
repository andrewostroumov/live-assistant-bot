# config valid only for current version of Capistrano
lock "3.7.2"

set :application, "live_assistant_bot"
set :repo_url, "git@github.com:andrewostroumov/live-assistant-bot.git"

set :rbenv_type, :user
set :rbenv_ruby, "2.4.0"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, ".env"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

append :linked_dirs, "log"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

after "deploy:finished", "initialize"

task :initialize do
  on roles(:app) do
    within current_path do
      with assistant_env: :production do
        execute(:ruby, "run.rb")
      end
    end
  end
end
