require 'serverspec'
require 'helpers'
require 'faraday'

# set :path, '/sbin:$PATH'

set :backend, :exec

include Helpers

RSpec.configure do |c|
  c.output_stream = File.open("#{Dir.pwd}/serverspec.html", 'w')
  c.formatter = 'html'
end