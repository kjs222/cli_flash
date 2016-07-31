require 'rspec'
require 'faraday'
require './lib/session_service.rb'
require_relative 'spec_helper'

describe "SessionService" do

  xit "starts a session when user and skill matches " do
    stub_omniauth
    skill_name = "test"
    #even if i can stub omniauth, i can't create a skill for the user
    connection = Faraday.new('http://127.0.0.1:3000')
    skill = post "api/v1/skills?user_id=1&nickname=#{skill_name}"
    skill = JSON.parse(skill)

    #CANT GET ANY OF THIS TO WORK


  end





end
