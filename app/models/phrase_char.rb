class PhraseChar

  include ActiveModel::Model

  attr_accessor(
    :letter,
    :guessed_letters
  )

  def masked
    return white_space_mask if whitespace?
    return char_mask unless guessed?
    letter.upcase
  end

  def guessed?
    guessed_letters.chars.any? { |char|
      char.casecmp(letter) == 0
    }
  end

  def whitespace?
    letter =~ /\s/
  end

  private

  def white_space_mask
    '*'
  end

  def char_mask
    '_'
  end

end
