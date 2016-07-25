require 'rspec'
require 'capybara'
require 'capybara/dsl'
require 'spec_helper.rb'

Capybara.default_driver = :selenium
Capybara.app_host = "http://www.google.com"

# http://testerstories.com/2011/08/using-rspec-and-capybara-without-rails/



describe "Searching for a video" do
  it "allows searches for general terms" do
  end
end
