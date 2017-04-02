class BigFiveResultTextSerializer
  def initialize(test_result_str)
    @test_string = test_result_str
  end

  def to_hash
    header_hash = {
      'NAME' => 'Eduardo Marques',
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
          if sub_hash.include?('Facets')
            sub_hash['Facets'] = facets_hash
            result_hash[header_line[0]] = sub_hash
          end

          header_line = l.split(/\.{3,}/)
          sub_hash['Overall Score'] = header_line[1].to_i
          sub_hash['Facets'] = nil
        end

        if l.match?(/^\.\.[A-Z]/)
          result_line = l.split(/\.{3,}/)
          facets_hash[result_line[0].delete(".")] = result_line[1].to_i
        end
      end
    end

    # Insert the last facet |TODO: Refact
    sub_hash['Facets'] = facets_hash
    result_hash[header_line[0]] = sub_hash

    return result_hash
  end

end
