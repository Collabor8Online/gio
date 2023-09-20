require "bundler/setup"
load "tasks/otr-activerecord.rake"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)
task default: [:spec]

namespace :db do
  task :environment do
    require_relative "config/environment"
  end
end
