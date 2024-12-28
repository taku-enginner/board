class BoardsController < ApplicationController
  def index
    @boards = Board.all.order(created_at: :desc)
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      redirect_to boards_path, notice: '掲示板を作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to board_path(@board), notice: '掲示板を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to boards_path, notice: '掲示板を削除しました', status: :see_other
  end

  private

  def board_params
    params.require(:board).permit(:title, :content, :image)
  end
end
