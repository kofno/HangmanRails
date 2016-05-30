class Guess

  include ActiveModel::Model

  POSSIBLE_GUESSES = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".chars.freeze

  def self.create(game, params, callbacks)
    return callbacks[:failure][ message: "Game Over, Man! Game Over!" ] if game.over?

    guess = new(params.merge(guessed_letters: game.guessed_letters))
    return callbacks[:failure].call(
      message: guess.errors.full_messages.join("\n")
    ) unless guess.valid?

    game.make_guess(guess.value)
    callbacks[ :success ].call
  end

  attr_writer(
    :value,
    :guessed_letters
  )

  validates(
    :value,
    length: { is: 1 },
    format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" },
    exclusion: { in: :guessed_letters, message: "%{value} has already been guessed" }
  )

  def value
    return nil unless @value
    @value.to_s.upcase
  end

  def guessed_letters
    (@guessed_letters || "").upcase
  end


  def guessed?
    guessed_letters.chars.any? { |char|
      value.casecmp(char) == 0
    }
  end



end
