class TasksController < ApplicationController
    def show
        @board = Board.find(params[:board_id])
        @task = @board.tasks.find(params[:id])
        @comments = @task.comment
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
        if @task.save
          redirect_to board_path(board), notice: 'タスクを追加'
        else
          flash.now[:error] = '更新できませんでした'
          render :new
        end
    end
      

    def destroy
        @board = Board.find(params[:board_id])
        @task = @board.tasks.find(params[:id])
        @task.destroy! #記事の削除 !はデストロイ失敗した時にエラーがでて処理が止まる。
        redirect_to board_path(@board), notice: '削除に成功しました' #削除後、記事一覧に飛ぶ
    end

    def update
        @board = Board.find(params[:board_id])
        @task = @board.tasks.find(params[:id])
        if @task.update!(task_params)
          redirect_to board_task_path(board_id: @board.id, id: @task.id), notice: 'タスクを追加'
        else
          flash.now[:error] = '更新できませんでした'
          render :new
        end
    end
    def edit
        board = Board.find(params[:board_id])
        @task = board.tasks.find(params[:id])
    end
    
    private
  def task_params
    params.require(:task).permit(:title, :content, :eyecatch, :deadline).merge(user_id: current_user.id)
  end
end