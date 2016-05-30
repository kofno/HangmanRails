class Game < ApplicationRecord

  enum status: [:in_progress, :lost, :won]

  belongs_to :puzzle

  validates :status, presence: true

  def guessed_letters
    self[:guessed_letters] || ""
  end

  def over?
    !in_progress?
  end

  def guesses
    Guess::POSSIBLE_GUESSES.map { |letter|
      Guess.new(value: letter, guessed_letters: guessed_letters)
    }
  end

  def phrase_chars
    puzzle.phrase.chars.map { |letter|
      PhraseChar.new(letter: letter, guessed_letters: guessed_letters)
    }
  end

  def misses
    guessed_letters.chars.select{ |char| !puzzle.includes?(char) }.size
  end

  def make_guess(letter)
    add_guessed_letter(letter)
    update_status
  end

  def update_status
    return self.lost! if misses >= 6
    return self.won! if phrase_chars.reject(&:whitespace?).all?(&:guessed?)
    self.in_progress!
  end

  def add_guessed_letter(letter)
    self.guessed_letters = (
      guessed_letters.upcase.chars + Array(letter.upcase)
    ).uniq.sort.join
  end

end
