require 'rvm/capistrano'
require 'bundler/capistrano'
require 'capistrano/ext/multistage'
require 'capistrano_colors'

#load 'deploy/assets'

default_run_options[:pty] = true

set :application, "blog-ror"
set :repository,  "git://github.com/stamm/blog-ror.git"

set :stages,        %w(staging production development)
set :default_stage, 'development'
set :branch,        'master'


set :using_rvm, true
set :rvm_type, :user
set :rvm_ruby_string, 'ruby-2.0.0-p0'
# интеграция rvm с capistrano настолько хороша, что при выполнении cap deploy:setup установит себя и указанный в rvm_ruby_string руби.
before 'deploy:setup', 'rvm:install_rvm', 'rvm:install_ruby'


set :use_sudo, false


set :scm, :git
set :scm_verbose, true
set :deploy_via, :remote_cache
set :branch, "master"
set :keep_releases, 4


after "deploy:update", "deploy:cleanup"
set :bundle_without, [:test, :development]


set(:unicorn_conf) { "config/unicorn.rb" }
set(:unicorn_pid) { "#{deploy_to}/shared/pids/unicorn.pid" }


####################

##set :rvm_ruby_string, 'ree' # Это указание на то, какой Ruby интерпретатор мы будем использовать.
#set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")




# Optional
before "deploy",                 "deploy:assets:precompile"
before "deploy",                 "deploy:web:disable"
before "deploy:stop",            "deploy:web:disable"

after  "deploy:update_code",     "deploy:symlink_shared"

# Optional
after  "deploy:start",           "deploy:web:enable"
after  "deploy",                 "deploy:web:enable"

after  "deploy",                 "deploy:cleanup"



# Далее идут правила для перезапуска unicorn. Их стоит просто принять на веру - они работают.
namespace :deploy do
  desc "restart unicorn server"
  task :restart do
    # && [ -e /proc/$(cat #{unicorn_pid}) ]
    run "if [ -f #{unicorn_pid} ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end

  desc "start unicorn server"
  task :start do
    run "cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end

  desc "stop unicorn server"
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end


  desc "Link in the production database.yml and assets"
  task :symlink_shared do
    # Здесь для примера вставлен только один конфиг с приватными данными - database.yml.
    # Обычно для таких вещей создают папку /srv/myapp/shared/config и кладут файлы туда.
    # При каждом деплое создаются ссылки на них в нужные места приложения.
    run "rm -f #{current_release}/config/database.yml"
    run "ln -s #{deploy_to}/shared/config/database.yml #{current_release}/config/database.yml"
  end

  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      #from = source.next_revision(current_revision)
      #if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      #else
      #  logger.info "Skipping asset pre-compilation because there were no asset changes"
      #end
    end
  end

  namespace :web do

    desc "Maintenance start"
    task :disable, :roles => :web do
      on_rollback { run "rm #{shared_path}/system/maintenance.html" }
      page = File.read("public/503.html")
      put page, "#{shared_path}/system/maintenance.html", :mode => 0644
    end

    desc "Maintenance stop"
    task :enable, :roles => :web do
      run "rm #{shared_path}/system/maintenance.html"
    end
  end
end


namespace :log do
  desc "A pinch of tail"
  task :tailf, :roles => :app do
    run "tail -n 10000 -f #{shared_path}/log/#{rails_env}.log" do |channel, stream, data|
      puts "#{data}"
      break if stream == :err
    end
  end
end


#set :ssh_option, { :forward_agent => true }
#default_run_options[:shell] = 'bash -l'
