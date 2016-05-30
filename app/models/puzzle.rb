class Puzzle < ApplicationRecord

  has_many :games

  # Fetch a puzzle at random from the database
  def self.random
    offset(rand(count)).first
  end

  def includes?(guess)
    phrase.chars.any? { |puzzle_char|
      puzzle_char.casecmp(guess) == 0
    }
  end

end
