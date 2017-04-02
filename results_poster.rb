require 'faraday'
require 'json'

class BigFiveResultsPoster
  attr_reader :response_code, :token

  def initialize(results_hash)
    if not results_hash.nil? and results_hash.is_a?(Hash)
      @results = results_hash
    end
  end

  def post
    conn = Faraday.new(:url => 'https://recruitbot.trikeapps.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    response = conn.post do |req|
      req.url 'https://recruitbot.trikeapps.com/api/v1/roles/mid-senior-web-developer/big_five_profile_submissions'
      req.headers['Content-Type'] = 'application/json'
      req.body = @results.to_json
    end

    @response_code = response.status

    if response.status == 201
      @token = response.body
    elsif response.status == 422
      # print the errors into STDOUT
      puts "RESPONSE ERRORS:"
      puts "#{response.body}"
      return false
    end

    return true
  end
end
