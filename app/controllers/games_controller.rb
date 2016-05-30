class GamesController < ApplicationController

  def index
    @games = Game.where(player_id: session[:player_id]).in_progress
    @game = Game.new(player_id: session[:player_id])
  end

  def create
    @game = Game.new(
      puzzle: Puzzle.random,
      status: :in_progress,
      player_id: session[:player_id]
    )
    if @game.save
      redirect_to @game
    else
      render :index
    end
  end

  def show
    @game = Game
      .where(player_id: session[:player_id])
      .find(params[:id])
  end

end
