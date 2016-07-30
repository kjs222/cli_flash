require 'faraday'
require 'json'
require 'pry'

class SessionService

  def initialize
    # figure out how ot make this work for dev and prod
    @connection = Faraday.new('http://127.0.0.1:3000')
  end


  def start_practice_session(skill_name)
    # if NO CREDENTIALS File.read("path/to/file")
    #
    # else
      user_id = IO.readlines("/tmp/credentials.txt")[0].chomp
      response = @connection.post("api/v1/sessions/cli?session[user_id]= #{user_id}&session[skill_name]=#{skill_name}&session[type]=start")
      p JSON.parse(response.body)
    # end
  end

  def end_practice_session(skill_name)
    # if NO CREDENTIALS File.read("path/to/file")
    #
    # else
      response = @connection.patch("api/v1/sessions/cli?skill_name=#{skill_name}&type=stop")
      JSON.parse(data.body)
    # end
  end

end

SessionService.new.start_practice_session("New Skill")
