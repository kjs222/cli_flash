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

  def get_set_id_from_title(title)
    set = get_quizsets.find do |quizset|
      quizset["title"] == title
    end
    set["id"]
  end

  def get_terms_in_set(title)
    set_id = get_set_id_from_title(title)
    data = @connection.get("2.0/sets/#{set_id}/terms")
    JSON.parse(data.body)
  end

  def display_terms(title)
    get_terms_in_set(title).each do |term|
      puts term["term"]
    end
  end

  def add_term_to_set(title, term, definition)
    set_id = get_set_id_from_title(title)
    @connection.post("/2.0/sets/#{set_id}/terms?term=#{term}&definition=#{definition}")
  end

  def add_set(title)
    @connection.post("2.0/sets?title=#{title}&terms[]=x&definitions[]=x&terms[]=y&definitions[]=y&lang_terms=en&lang_definitions=en&description=command_line")
  end


end
