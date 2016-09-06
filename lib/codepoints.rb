require 'thor'
require_relative 'quizlet_service'
require_relative 'session_service'
require_relative 'authentication_service'

class CodepointsCLI < Thor

  desc "setup NICKNAME PASSWORD", "verifies user and sets gets token for api"
    def setup(nickname, password)
      AuthenticationService.new(nickname, password).authenticate
    end

  desc "quizsets", "returns the titles of all quizsets"
    def quizsets
      if File.exists?("/tmp/credentials.txt")
        id, token = AuthenticationService.read_quizlet_credentials
        QuizletService.new(id, token).display_quizsets
      else
        puts "Not authenticated.  Call 'quizlet authenticate nickname password'"
      end
    end

  desc "terms TITLE", "gets terms and displays them as output"
    def terms(*title)
      set_title = title.join(' ')
      id, token = AuthenticationService.read_quizlet_credentials
      QuizletService.new(id, token).display_terms(set_title)
    end

  desc "add_term TITLE", "adds a term to a quizset"
    def add_term(*title)
      set_title = title.join(' ')
      term = ask("Term: ")
      definition = ask("Definition: ")
      id, token = AuthenticationService.read_quizlet_credentials
      QuizletService.new(id, token).add_term_to_set(set_title, term, definition)
    end

    desc "new_set TITLE", "adds a set to quizlet"
      def new_set(*title)
        set_title = title.join(' ')
        id, token = AuthenticationService.read_quizlet_credentials
        QuizletService.new(id, token).add_set(set_title)
      end

    desc "start SKILL_NAME", "starts a practice session"
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
