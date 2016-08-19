source 'https://rubygems.org'

# Used by Travis

gem 'foodcritic'
gem 'minitest'
gem 'rake'
gem 'rubocop'
gem 'chefspec'

gem 'berkshelf', '~> 4.0' # Comes with ChefDK 0.9.0
gem 'serverspec'

group :docker do
  gem 'test-kitchen', '~> 1.4'
  gem 'kitchen-docker', '~> 2.1.0'
  gem 'kitchen-verifier-serverspec'
end

group :vagrant do
  gem 'vagrant-wrapper', '~> 2.0'
  gem 'kitchen-vagrant', '~> 0.18'
end
