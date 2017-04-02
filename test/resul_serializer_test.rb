require 'minitest/autorun'

class BigFiveResultTextSerializer
  def initialize(test_result_str)

  end

  def to_hash
    {
      'name' => 'Eduardo Marques',
      'EMAIL' => 'eduardo.marques81@gmail.com',
      'EXTRAVERSION' => {
        'Overall Score' => 92
      }
    }
  end
end

describe BigFiveResultTextSerializer do
  before do
    @basic_text = <<-RESULT
    Extraversion
    Extraversion is marked by pronounced engagement with the external world. Extraverts enjoy being with people, are full of energy, and often experience positive emotions. They tend to be enthusiastic, action-oriented, individuals who are likely to say "Yes!" or "Let's go!" to opportunities for excitement. In groups they like to talk, assert themselves, and draw attention to themselves.
    Introverts lack the exuberance, energy, and activity levels of extraverts. They tend to be quiet, low-key, deliberate, and disengaged from the social world. Their lack of social involvement should not be interpreted as shyness or depression; the introvert simply needs less stimulation than an extravert and prefers to be alone. The independence and reserve of the introvert is sometimes mistaken as unfriendliness or arrogance. In reality, an introvert who scores high on the agreeableness dimension will not seek others out but will be quite pleasant when approached.

    Domain/Facet............ Score
    EXTRAVERSION...............87
    ..Friendliness.............94
    ..Gregariousness...........80
    ..Assertiveness............81
    ..Activity Level...........88
    ..Excitement-Seeking.......46
    ..Cheerfulness.............66

    Your score on Extraversion is high, indicating you are sociable, outgoing, energetic, and lively. You prefer to be around people much of the time.
    Extraversion Facets
    RESULT

    @serializer =  BigFiveResultTextSerializer.new @basic_text
  end

  it "should retrie a non-empty hash from the tex" do
    @serializer.wont_be_nil
    @serializer.to_hash.wont_be_nil
    @serializer.to_hash.size.must_be :==, 3
  end
end