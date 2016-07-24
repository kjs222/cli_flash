require 'thor'
require 'faraday'
require 'json'
require 'figaro'
# APIID = 'ACPSE89AY8'
# APIKEY = 'qfzpgN94Ag3gayPYv3dyjP'


class QuizletCLI < Thor

  desc "quiz_sets", "Returns the titles for all of your quiz sets"
    def quiz_sets
      connection = Faraday.new('https://api.quizlet.com')
      connection.headers["Authorization"] = "Bearer 4vGGwud3seTc2WxJEbsV72YMcKzZwymYbGPMKERp"
      data = connection.get("/2.0/users/kjs222/sets")
      parsed_data = JSON.parse(data.body)
      parsed_data.each do |quiz_set|
        puts quiz_set["title"]
      end
    end


end


QuizletCLI.start(ARGV)
