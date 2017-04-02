
class BigFiveResultTextSerializer
  def initialize(test_result_str)
    @test_string = test_result_str
  end

  def to_hash
    header_hash = {
      'name' => 'Eduardo Marques',
      'EMAIL' => 'eduardo.marques81@gmail.com',
    }

    body_hash = parse_text @test_string

    result_hash = header_hash.merge body_hash

    return result_hash
  end

  private
  def parse_text text
    result_hash = {}
    sub_hash = {}
    facets_hash = {}
    header_line = []

    text.each_line do |l|
      if l.match?(/\.\.\d/) # only doted lines with value
        if l.match?(/^[A-Z]/) # start with letter -- HEADER
          if sub_hash.include?('facets')
            sub_hash['facets'] = facets_hash
            result_hash[header_line[0]] = sub_hash
          end

          header_line = l.split(/\.{3,}/)
          sub_hash['overall_score'] = header_line[1].to_i
          sub_hash['facets'] = nil
        end

        if l.match?(/^\.\.[A-Z]/)
          result_line = l.split(/\.{3,}/)
          facets_hash[result_line[0].delete(".")] = result_line[1].to_i
        end
      end
    end

    # TODO: Refactor repeated code
    sub_hash['facets'] = facets_hash
    result_hash[header_line[0]] = sub_hash

    return result_hash
  end
end
