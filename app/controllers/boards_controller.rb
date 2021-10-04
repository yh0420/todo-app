class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def show
  end

  def create
    @board.save
  end
end

#@board = Board.first