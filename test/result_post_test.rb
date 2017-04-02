require 'minitest/autorun'
require 'json'
require 'results_serializer.rb'
require 'results_poster.rb'
require 'faraday'
require_relative 'fixtures.rb'

describe BigFiveResultsPoster do
  before do
    @serializer =  BigFiveResultTextSerializer.new get_text
    @results_poster = BigFiveResultsPoster.new @serializer.to_hash
  end

  it "should post a random json to the bot" do
    #@results_poster.post.must_equal true
    conn = Faraday.new(:url => 'https://recruitbot.trikeapps.com/api/v1/roles/mid-senior-web-developer/big_five_profile_submissions') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    response = conn.post do |req|
      req.url 'https://recruitbot.trikeapps.com/api/v1/roles/mid-senior-web-developer/big_five_profile_submissions'
      req.headers['Content-Type'] = 'application/json'
      #req.body = '{ "name": "Unagi" }'
      puts "====>>>> JSON BODY: #{ @serializer.to_hash.to_json}"
      req.body = @serializer.to_hash.to_json
    end

    puts "=====>>> RESPONSE: #{response.body} "
  end
end
