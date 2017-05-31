source 'https://rubygems.org'

# Used by Travis

gem 'inspec', '~>1.2.1'
gem 'foodcritic', '~> 10.2.0'
gem 'cookstyle', '~> 1.2.0'
gem 'berkshelf', '~> 5.1.0'
gem 'chefspec', '~> 5.3.0'
gem 'coveralls', require: false
gem 'rake', '~> 12.0.0'
gem 'chef', '~> 12.19.36'
gem 'yamllint'

group :docker do
  gem 'test-kitchen', '~> 1.4'
  gem 'kitchen-docker', '~> 2.6.0'
  gem 'kitchen-inspec', '~> 0.18.0'
end

group :vagrant do
  gem 'vagrant-wrapper', '~> 2.0'
  gem 'kitchen-vagrant', '~> 0.18'
end
