# for Capistrano 3.4
lock '3.4.0'

set :user, 'deployer'

set :application, 'owl'
set :deploy_to, "/app/www/#{fetch(:application)}"

set :repo_url, 'https://github.com/linshi/owlabc.git'
# Default branch is master, support to set via command line
set :branch, ask(:branch, 'master')

# set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

set :keep_releases, 3

# rbenv
set :rbenv_roles, %w{app}
set :rbenv_custom_path, "/home/#{fetch(:user)}/.rbenv"
set :rbenv_ruby, '2.2.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# nginx
# The port the application server is running on
# It should be same as the port which unicon listen on
set :app_server_port, 9000
set :app_server_host, "localhost"
set :nginx_domains,   "localhost"
set :nginx_log_path,  "/var/log/nginx"

# Task
namespace :db do
  desc 'db load seeds'
  task :seed do
    on roles(:db), in: :sequence, wait: 5 do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end
end

# when you deploy this code to a new environment at first time,
# you need to run the following commands:
#   1. cap [rails_env] deploy:check
#   2. cap [rails_env] nginx:site:add
#   3. cap [rails_env] nginx:site:enable
# after you deploy the code, you need to run the following command:
#   1. cap [rails_env] db:seed
namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:legacy_restart'
    invoke 'nginx:restart'
  end

  after :publishing, :restart
end
