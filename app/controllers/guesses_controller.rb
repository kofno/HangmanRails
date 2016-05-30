class GuessesController < ApplicationController

  before_action :load_game

  def create
    Guess.create(
      @game,
      guess_params,
      success: -> { redirect_to(@game) },
      failure: ->(error) {
        flash.now[:error] = error[:message]
        render :index
      }
    )
  end

  protected

  def guess_params
    params.require(:guess).permit(:value)
  end

  def load_game
    @game = Game.where(player_id: session[:player_id]).find(params[:game_id])
  end

end
