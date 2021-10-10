class TasksController < ApplicationController
    def show
    end

    def index
        @tasks = Task.all #タスクを配列にして挿入
    end
    

    def new
        board = Board.find(params[:board_id]) #boardにBoardのidをfindし、 
        @task = board.tasks.build   # board/board_id/taskをビルド
    end
        
    def create
        board = Board.find(params[:board_id])
        @task = board.tasks.build(task_params) 
        if @task.save!
          redirect_to board_path(board), notice: 'タスクを追加'
        else
          flash.now[:error] = '更新できませんでした'
          render :new
        end
    end
      

    def destroy
    end

    def update
    end

    private
  def task_params
    params.require(:task).permit(:title, :content, :eyecatch, :deadline).merge(user_id: current_user.id )
  end
end