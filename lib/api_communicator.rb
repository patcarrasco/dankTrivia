def question_array_from_api(api_address)
  response_string = RestClient.get(api_address)
  response_hash = JSON.parse(response_string)
  return response_hash["results"]
end

def question_array_merger(questions)
 final_array = questions.map { |address| question_array_from_api(address) }
 final_array.flatten!
 final_array
 # binding.pry
end

# GET QUESTIONS

def convert_key_to_symbol(questions)
  array = question_array_merger(questions)
  question_list = []
  array.each do |question|
    new = {}
    question.each do |k, v|
      v.gsub!("&quot;", "'") if k.to_sym != :incorrect_answers
      v.gsub!("&#039;", "'") if k.to_sym != :incorrect_answers
      v.gsub!("&eacute;", "e") if k.to_sym != :incorrect_answers
      new[k.to_sym] = v
      if k.to_sym == :incorrect_answers
        v.map do |string|
          string.gsub!("&quot;", "'")
          string.gsub!("&#039;", "'")
        end
        new[:option1] = v[0]
        new[:option2] = v[1] if v.size > 1
        new[:option3] = v[2] if v.size > 1
        new.delete(k.to_sym)
      end
    end
    # binding.pry
    question_list << new if !question_list.include?(new)
  end
  question_list
end
