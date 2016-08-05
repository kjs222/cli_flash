require 'thor'
require_relative 'quizlet_service'
require_relative 'session_service'
require_relative 'authentication_service'

class CodepointsCLI < Thor

  desc "quizsets", "Returns the titles for all of your quiz sets"
    def quizsets
      if File.exists?("/tmp/credentials.txt")
        id, token = AuthenticationService.read_quizlet_credentials
        QuizletService.new(id, token).display_quizsets
      else
        puts "Not authenticated.  Call 'quizlet authenticate nickname password'"
      end
    end

  desc "setup NICKNAME PASSWORD", "verifies user and sets gets token for api"
    def setup(nickname, password)
      AuthenticationService.new(nickname, password).authenticate
    end

  desc "terms TITLE", "gets terms and displays them as output"
    def terms(*title)
      new_title = title.join(' ')
      id, token = AuthenticationService.read_quizlet_credentials
      QuizletService.new(id, token).display_terms(new_title)
    end

  desc "add_term TITLE", "adds a term to a set"
    def add_term(*title)
      new_title = title.join(' ')
      term = ask("Term: ")
      definition = ask("Definition: ")
      id, token = AuthenticationService.read_quizlet_credentials
      QuizletService.new(id, token).add_term_to_set(new_title, term, definition)
    end

    desc "new_set TITLE", "adds a set to quizlet"
      def new_set(*title)
        new_title = title.join(' ')
        id, token = AuthenticationService.read_quizlet_credentials
        QuizletService.new(id, token).add_set(new_title)
      end

    desc "start SKILL_NAME", "starts a pratice session"
      def start(*skill_name)
        session_skill = skill_name.join(' ')
        response= SessionService.new.start_practice_session(session_skill)
        puts response["response"]
      end

    desc "stop SKILL_NAME", "stops a pratice session"
      def stop(*skill_name)
        session_skill = skill_name.join(' ')
        response= SessionService.new.stop_practice_session(session_skill)
        puts response["response"]
      end

end
