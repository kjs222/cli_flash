require 'faraday'
require 'json'
require 'pry'

class AuthenticationService

  attr_reader :uid, :password

  def initialize(uid, password)
    @uid = uid
    @password = password
    @connection = Faraday.new('http://localhost:3000')
  end

  def get_credentials
    data = @connection.get("/api/v1/authenticate?uid=#{uid}&password=#{password}")
    JSON.parse(data.body)
  end

  def write_credentials_to_file(credentials)
    File.open("/tmp/credentials.txt",'w') do |file|
      file.puts credentials["uid"]
      file.puts credentials['token']
    end
  end

  def self.read_credentials
    id = IO.readlines("/tmp/credentials.txt")[0].chomp
    token = IO.readlines("/tmp/credentials.txt")[1].chomp
    [id, token]
  end

  def authenticate
    credentials = get_credentials
    if credentials["uid"] == "User not found"
      puts "Failed: User was not found"
    else
      write_credentials_to_file(credentials)
      puts "Success: credentials have been saved"
    end
  end

end
