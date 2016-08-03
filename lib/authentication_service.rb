require 'faraday'
require 'json'
require 'pry'

class AuthenticationService

  attr_reader :nickname, :password

  def initialize(nickname, password)
    @nickname = nickname
    @password = password
    @connection = Faraday.new('http://codepoints.herokuapp.com')
  end

  def get_credentials
    data = @connection.get("/api/v1/authenticate?nickname=#{nickname}&password=#{password}")
    JSON.parse(data.body)
  end

  def write_credentials_to_file(credentials)
    File.open("/tmp/credentials.txt",'w') do |file|
      file.puts credentials["id"]
      file.puts credentials["quiz_id"]
      file.puts credentials['quiz_token']
    end
  end

  def self.read_quizlet_credentials
    quiz_id = IO.readlines("/tmp/credentials.txt")[1].chomp
    quiz_token = IO.readlines("/tmp/credentials.txt")[2].chomp
    [quiz_id, quiz_token]
  end

  def self.read_user_id
    IO.readlines("/tmp/credentials.txt")[0].chomp
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
