#!/usr/bin/env rake

require 'foodcritic'
require 'rspec/core/rake_task'

desc "Runs knife cookbook test"
task :knife do
  sh "bundle exec knife cookbook test cookbook -o ./ -a"
end

desc "Runs foodcritic test"
task :foodcritic do
  FoodCritic::Rake::LintTask.new
  sh "bundle exec foodcritic -f any ."
end

desc "Runs rspec tests in test/unit folder"
task :unit do
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = "test/unit/**/*_spec.rb"
  end
end

desc "Package Berkshelf distro"
task :dist do
  FoodCritic::Rake::LintTask.new
  sh "bundle exec berks package chef-alfresco.tar.gz"
end

task :integration do
  begin
    require 'kitchen/rake_tasks'
    Kitchen::RakeTasks.new
  rescue LoadError
    puts ">>>>> Kitchen gem not loaded, omitting kitchen tasks" unless ENV['CI']
  end
end

task :default => [:foodcritic, :knife, :unit]
