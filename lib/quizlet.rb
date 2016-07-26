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

  desc "terms TITLE", "gets terms and displays them as output"
    def terms(*title)
      new_title = title.join(' ')
      id, token = AuthenticationService.read_credentials
      QuizletService.new(id, token).display_terms(new_title)
    end

  desc "add_term TITLE", "adds a term to a set"
    def add_term(*title)
      new_title = title.join(' ')
      term = ask("Term: ")
      definition = ask("Definition: ")
      id, token = AuthenticationService.read_credentials
      QuizletService.new(id, token).add_term_to_set(new_title, term, definition)
    end


end
