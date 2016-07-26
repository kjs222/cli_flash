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




end
