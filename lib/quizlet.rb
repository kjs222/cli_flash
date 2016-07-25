require 'thor'
require 'faraday'
require 'json'
require 'pry'

class QuizletCLI < Thor

  desc "quiz_sets", "Returns the titles for all of your quiz sets"
    def quiz_sets
      uid, token = set_credentials
      if token == ''
        puts "Please call 'get_token uid password'"
      else
        connection = Faraday.new('https://api.quizlet.com')
        connection.headers["Authorization"] = "Bearer " + token
        data = connection.get("/2.0/users/#{uid}/sets")
        parsed_data = JSON.parse(data.body)
        parsed_data.each do |quiz_set|
          puts quiz_set["title"]
        end
      end
    end

  desc "get_token UID PASSWORD", "gets token and sets it as env variable"
    def get_token(uid, password)
      connection = Faraday.new('http://localhost:3000')
      data = connection.get("/api/v1/authenticate?uid=#{uid}&password=#{password}")
      parsed_data = JSON.parse(data.body)
      #add if/else on here for if these are "User not found"
      token = parsed_data["token"]
      uid = parsed_data["uid"]
      File.open("/tmp/credentials.txt",'w') do |file|
        file.puts uid
        file.puts token
      end
      puts "Success: credentials have been saved"
    end

    desc "set credentials", "sets uid and token"
    def set_credentials
      token = '' 
      uid = ''
      open("/tmp/credentials.txt") do |f|
        uid = f.readlines[0].chomp
        f.rewind
        token = f.readlines[1].chomp
      end
      [uid, token]
    end

end
