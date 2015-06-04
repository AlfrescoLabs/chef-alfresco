#!/usr/bin/env rake

require 'foodcritic'
require 'rspec/core/rake_task'
require 'rake'

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
  sh "rm -rf Berksfile.lock ; bundle exec berks package chef-alfresco.tar.gz"
end

desc "Updates cookbook version in metadata.rb"
task :update_version, [:releaseversion] do |t,args|
  version = args[:releaseversion]
  sh "sed 's/version \".*\"/version \"#{version}\"/' metadata.rb > metadata.rb.tmp ; rm -f metadata.rb ; mv metadata.rb.tmp metadata.rb"
end

desc "Deploy dist into Nexus artifact"
task :deploy, [:releaseversion] do |t,args|
  version = args[:releaseversion]
  sh "mvn deploy:deploy-file -Dfile=chef-alfresco.tar.gz -DrepositoryId=alfresco-private-repository -Durl=https://artifacts.alfresco.com/nexus/content/repositories/internal-snapshots -DgroupId=org.alfresco.devops -DartifactId=chef-alfresco -Dversion=#{version}-SNAPSHOT -Dpackaging=tar.gz"
end

task :integration do
  begin
    require 'kitchen/rake_tasks'
    Kitchen::RakeTasks.new
  rescue LoadError
    puts ">>>>> Kitchen gem not loaded, omitting kitchen tasks" unless ENV['CI']
  end
end

task :default => [:foodcritic, :knife, :unit, :dist]
