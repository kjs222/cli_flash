require 'thor'
require 'pry'
require_relative 'quizlet_service'
require_relative 'authentication_service'

class QuizletCLI < Thor

  desc "quizsets", "Returns the titles for all of your quiz sets"
    def quizsets
      id, token = AuthenticationService.read_credentials
      if token == ''
        puts "Not authenticated.  Call 'authenticate uid password'"
      else
        QuizletService.new(id, token).display_quizsets
      end
    end

  desc "get_token UID PASSWORD", "gets token and sets it as env variable"
    def authenticate(uid, password)
      AuthenticationService.new(uid, password).authenticate
    end

    # desc "set credentials", "sets uid and token"
    # def set_credentials
    #   token = ''
    #   uid = ''
    #   open("/tmp/credentials.txt") do |f|
    #     uid = f.readlines[0].chomp
    #     f.rewind
    #     token = f.readlines[1].chomp
    #   end
    #   [uid, token]
    # end

end
