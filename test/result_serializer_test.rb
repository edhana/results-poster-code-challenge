require 'minitest/autorun'
require 'results_serializer.rb'
require_relative 'fixtures.rb'

describe BigFiveResultTextSerializer do
  before do
    @basic_text = get_text

    @serializer =  BigFiveResultTextSerializer.new @basic_text
  end

  it "should retrie a non-empty hash from the text" do
    @serializer.wont_be_nil
    @serializer.to_hash.size.must_be :>=, 3
  end

  it "should have the EXTRAVERSION header" do
    @serializer.to_hash.include?('EXTRAVERSION').must_equal true
  end

  it "should have all 5 headers" do
    @serializer.to_hash.include?('EXTRAVERSION').must_equal true
    @serializer.to_hash.include?('AGREEABLENESS').must_equal true
    @serializer.to_hash.include?('CONSCIENTIOUSNESS').must_equal true
    @serializer.to_hash.include?('NEUROTICISM').must_equal true
    @serializer.to_hash.include?('OPENNESS TO EXPERIENCE').must_equal true
  end
end
