require 'thor'
require 'pry'
require_relative 'quizlet_service'
require_relative 'authentication_service'

class QuizletCLI < Thor

  desc "quizsets", "Returns the titles for all of your quiz sets"
    def quizsets
      if File.exists?("/tmp/credentials.txt")
        id, token = AuthenticationService.read_credentials
        QuizletService.new(id, token).display_quizsets
      else
        puts "Not authenticated.  Call 'quizlet authenticate uid password'"
      end
    end

  desc "get_token UID PASSWORD", "gets token and sets it as env variable"
    def authenticate(uid, password)
      AuthenticationService.new(uid, password).authenticate
    end

end
