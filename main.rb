lib = File.expand_path('./', __FILE__)
#this will include the path in $LOAD_PATH unless it is already included
$LOAD_PATH.unshift(".") unless $LOAD_PATH.include?(".")

require 'results_serializer.rb'
require 'results_poster.rb'
require 'test/fixtures.rb'


@serializer =  BigFiveResultTextSerializer.new get_text

r = Random.new
result_hash = @serializer.to_hash
#result_hash['NAME'] = "Test man"
#result_hash['EMAIL'] = "testman#{r.rand(10.99)}@test.com"
results_poster = BigFiveResultsPoster.new result_hash
if results_poster.post
  puts "The test was sucessfully sended"
else
  puts "Server returned with error: #{results_poster.response_code}"
end
