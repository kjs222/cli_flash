require 'rspec'
require 'faraday'
require './lib/quizlet_service.rb'
require_relative 'token.rb'
require_relative 'spec_helper'
require 'stringio'

describe "QuizletService" do
  before(:each) do
    $stdout = StringIO.new
  end

  after(:all) do
    $stdout = STDOUT
  end

  it "gets quizsets from quizlet API" do
    qs = QuizletService.new("kjs222", TOKEN)
    VCR.use_cassette("quizsets") do
      results = qs.get_quizsets
      expect(results.count).to eq(12)
      expect(results.first['title']).to eq("oauth technical")
    end
  end

  it "prints quizset titles" do
    qs = QuizletService.new("kjs222", TOKEN)
    VCR.use_cassette("quizsets") do
      qs.display_quizsets
      expect($stdout.string).to include('oauth technical')
      expect($stdout.string).to include('controller tests')
    end
  end

  it "finds an id from a title" do
    qs = QuizletService.new("kjs222", TOKEN)
    VCR.use_cassette("quizsets") do
      id = qs.get_set_id_from_title("oauth technical")
      expect(id).to eq(145163778)
    end
  end

  it "get terms given a title" do
    qs = QuizletService.new("kjs222", TOKEN)
    # VCR.use_cassette("terms") do
      terms = qs.get_terms_in_set("test")
      expect(terms.first["term"]).to eq("first name")
    # end
  end

  it "adds a terms to a set given a title" do
    qs = QuizletService.new("kjs222", TOKEN)
    VCR.use_cassette("add_terms") do
      qs.add_term_to_set("test", "term-1", "definition-1")
      terms = qs.get_terms_in_set("test")
      expect(terms[-1]["term"]).to eq("term-1")
    end
  end

  it "prints quizset terms" do
    qs = QuizletService.new("kjs222", TOKEN)
      qs.display_terms("oauth technical")
      expect($stdout.string).to include('first oauth technical step')
      expect($stdout.string).to include('fourth oauth technical step')
  end

  it "adds a new set" do
    qs = QuizletService.new("kjs222", TOKEN)
    qs.add_set("new set")
    VCR.use_cassette("add_set") do
      results = qs.get_quizsets
      expect(results.count).to eq(14)
      expect(results.first['title']).to eq("new set")
    end
  end

end
