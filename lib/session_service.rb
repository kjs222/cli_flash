require 'faraday'
require 'json'
require 'pry'

class SessionService

  def initialize
    @connection = Faraday.new('https://codepoints.herokuapp.com')
  end

  def credentials_missing?
    !File.exist?('/tmp/credentials.txt')
  end

  def get_user_id
    IO.readlines("/tmp/credentials.txt")[0].chomp
  end

  def start_practice_session(skill_name)
    if credentials_missing?
      {"response" => "User is not authenticated"}
    else
      response = @connection.post("api/v1/sessions/cli?session[user_id]= #{get_user_id}&session[skill_name]=#{skill_name}")
      JSON.parse(response.body)
    end
  end

  def stop_practice_session(skill_name)
    if credentials_missing?
      {"response" => "User is not authenticated"}
    else
      response = @connection.patch("api/v1/sessions/cli?session[user_id]= #{get_user_id}&session[skill_name]=#{skill_name}")
      JSON.parse(response.body)
    end
  end

end
