require 'thor'
require 'faraday'
require 'json'
require 'figaro'
require 'pry'

ENV['FIGARO_ENVIRONMENT'] = "#{ENV['RACK_ENV']}" || 'development'

Figaro.application = Figaro::Application.new(environment: ENV['FIGARO_ENVIRONMENT'], path: 'application.yml')

Figaro.load

class QuizletCLI < Thor

  desc "quiz_sets", "Returns the titles for all of your quiz sets"
    def quiz_sets
      connection = Faraday.new('https://api.quizlet.com')
      connection.headers["Authorization"] = "Bearer " + ENV['QUIZLET_TOKEN']
      data = connection.get("/2.0/users/kjs222/sets")
      parsed_data = JSON.parse(data.body)
      parsed_data.each do |quiz_set|
        puts quiz_set["title"]
      end
    end


end


QuizletCLI.start(ARGV)
