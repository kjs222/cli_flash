require 'faraday'
require 'json'

class QuizletService

  attr_reader :uid

  def initialize(uid, token)
    @uid = uid
    @token = token
    @connection = Faraday.new('https://api.quizlet.com')
    @connection.headers["Authorization"] = "Bearer " + token
  end

  def get_quizsets
    data = @connection.get("/2.0/users/#{uid}/sets")
    JSON.parse(data.body)
  end

  def display_quizsets
    get_quizsets.each do |quiz_set|
      puts quiz_set["title"]
    end
  end

end
