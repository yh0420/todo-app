class BoardsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to root_path(@board), notice: '保存できたよ'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end
  
  def new
    @board = current_user.boards.build
  end

  def destroy
  end

  def edit
  end
end



private
def board_params
  params.require(:board).permit(:title, :content)
end
def set_board
  @board = Board.find(params[:id])
end
