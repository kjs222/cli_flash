require 'rspec'
require 'faraday'
require './lib/authentication_service.rb'
require_relative 'token.rb'

describe "AuthenticationService" do
  it "gets credentials from API for an existing user with correct credentials" do
    as = AuthenticationService.new("kjs222", "password")
    results = as.get_credentials
    expect(results['quiz_id']).to eq("kjs222")
    expect(results['quiz_token']).to eq(TOKEN)
  end

  it "gets user not found credentials from API for an existing user with incorrect credentials" do
    as = AuthenticationService.new("kjs222", "NOTpassword")
    results = as.get_credentials
    expect(results['quiz_id']).to eq("User not found")
    expect(results['quiz_token']).to eq("User not found")
  end

  it "gets user not found credentials from API for a non registered cli user" do
    as = AuthenticationService.new("NOTkjs222", "password")
    results = as.get_credentials
    expect(results['quiz_id']).to eq("User not found")
    expect(results['quiz_token']).to eq("User not found")
  end


  it "writes credentials to a file" do
    File.delete("/tmp/credentials.txt") if File.exists?("/tmp/credentials.txt")
    expect(File.exists?("/tmp/credentials.txt")).to eq(false)

    as = AuthenticationService.new("kjs222", "password")
    as.write_credentials_to_file(as.get_credentials)

    expect(File.exists?("/tmp/credentials.txt")).to eq(true)

    expect(IO.readlines("/tmp/credentials.txt")[1].chomp).to eq("kjs222")
    expect(IO.readlines("/tmp/credentials.txt")[2].chomp).to eq(TOKEN)
  end

  it "reads credentials from file" do
    as = AuthenticationService.new("kjs222", "password")
    if !File.exists?("/tmp/credentials.txt")
      as.write_credentials_to_file(as.get_credentials)
    end
    results = AuthenticationService.read_quizlet_credentials
    expect(results).to eq(['kjs222', TOKEN])
  end



end
