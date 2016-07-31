require 'vcr'
require 'webmock'
require_relative 'token.rb'


VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end

module StubOmniauth
  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      uid: "1",
      info: {
        name: "Kerry Sheldon",
        nickname: "kjs222"
            },
      credentials: {
        token: GITHUB_TOKEN
                    },
      extra: {
        raw_info: {
          avatar_url: "https://avatars.githubusercontent.com/u/11400778?v=3"
        }
              }
      })
  end
end


RSpec.configure do |config|
  config.include StubOmniauth
end
