class PersonalitiesController < ApplicationController
  # before_action :authenticate_user!
  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def show
  end

  def search
    service = WatsonAPIClient::PersonalityInsights.new(:user=>ENV["WATSON_USERNAME"],
                                                     :password=>ENV["WATSON_PASSWORD"],
                                                     :verify_ssl=>OpenSSL::SSL::VERIFY_NONE)
    result = service.profile(
      'Content-Type'     => "text/plain",
      'Accept'           => "application/json",
      'Accept-Language'  => "en",
      'Content-Language' => "en",
      'body'             => params["q"])

    @results = JSON.parse(result.body)
# see personalities controller for info passed through
# @results is returning parsed JSON, personalities is table
    new_record = Personality.new
    new_record.data = result
# q is the data the form sent through
    new_record.input = params["q"]
    new_record.title = params["title"]
    new_record.save
  end


end
