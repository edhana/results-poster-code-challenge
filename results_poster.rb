require 'faraday'

class BigFiveResultsPoster
  attr_reader :response_code, :token

  def initialize(results_hash)
    if not results_hash.nil? and results_hash.is_a?(Hash)
      @results = results_hash
    end
  end

  def post
    return false
  end
end
