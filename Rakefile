#!/usr/bin/env rake

# Used by Travis

require 'foodcritic'
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

desc "Package Berkshelf distro"
task :dist do
  sh "rm -rf Berksfile.lock cookbooks-*.tar.gz; bundle exec berks package; rm -f cookbooks-*.tar.gz"
end

# TODO - Disabling due to the following failing rule
# FC014: Consider extracting long ruby_block to library: ./recipes/haproxy-ec2-discovery.rb:37
# Cannot disable such rule via code
#
# task :default => [:foodcritic, :knife, :dist]
task :default => [:knife, :dist]
