module GuessesHelper

  def guess_class(guess)
    classes = [ 'guess' ]
    classes << [ 'guessed' ] if guess.guessed?
    classes.join(' ')
  end

end
