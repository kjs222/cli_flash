require 'vcr'
require 'webmock'


VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end


# RSpec.configure do |config|
#   config.include Capybara::DSL
# end
