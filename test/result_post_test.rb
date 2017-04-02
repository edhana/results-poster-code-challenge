require 'minitest/autorun'
require 'json'
require 'results_serializer.rb'
require 'results_poster.rb'
require_relative 'fixtures.rb'

describe BigFiveResultsPoster do
  before do
    @serializer =  BigFiveResultTextSerializer.new get_text
  end

  it "should fail with code 422 with an invalid hash" do
    poster = BigFiveResultsPoster.new({'test' => 'random value'})
    poster.post.must_equal false
    poster.token.must_be_nil
    poster.response_code.must_be :==, 422
  end

  it "should post a random json to the bot" do
    r = Random.new
    result_hash = @serializer.to_hash
    result_hash['NAME'] = "Test man"
    result_hash['EMAIL'] = "testman#{r.rand(10.99)}@test.com"
    results_poster = BigFiveResultsPoster.new result_hash
    results_poster.post.must_equal true
    results_poster.token.wont_be_nil
    results_poster.response_code.must_be :==, 201
  end
end
