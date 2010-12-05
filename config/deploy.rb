set :application, "nameptr-blog"
set :repository,  "git@github.com:sammcd/nameptr-blog.git"

set :scm, :git

role :web, "sammcd.com:32456"
role :app, "sammcd.com:32456"
role :db,  "sammcd.com:32456", :primary => true

set :default_environment, { 
  'PATH' => "/home/sammcd/.rvm/rubies/ruby-1.9.2-p0/bin:/home/sammcd/.rvm/gems/ruby-1.9.2-p0/bin:/home/sammcd/.rvm/bin:$PATH",
  'RUBY_VERSION' => 'ruby 1.9.2-p0',
  'GEM_HOME'     => '/home/sammcd/.rvm/gems/ruby-1.9.2-p0',
  'GEM_PATH'     => '/home/sammcd/.rvm/gems/ruby-1.9.2-p0',
  'BUNDLE_PATH'  => '/home/sammcd/.rvm/gems/ruby-1.9.2-p0'  # If you are using bundler.
}

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do ; end
  
  desc "Compile Jekyll and Compass stuff"
  task :compile do
    run "cd #{release_path} && rake compass:compile" 
    run "cd #{release_path} && rake jekyll:compile"
  end

end


after 'deploy:update_code', 'deploy:compile'
