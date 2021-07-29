class UsersController < ApplicationController
  #ログイン済みユーザーにのみアクセスを許可
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @questions = Question.where(user_id: @user.id)
    @questions_amount = Question.where(user_id: @user.id).count
    bookmarks = Bookmark.where(user_id: current_user.id).pluck(:question_id)
    @bookmark_lists = Question.find(bookmarks)
    @bookmark_lists_amount = Question.find(bookmarks).count
    comments = Comment.where(user_id: current_user.id).pluck(:question_id)
    @answered_questions = Question.find(comments)
    @answered_questions_amount = Question.find(comments).count
  end

  def edit
    @user = User.find(params[:id])
    #ログイン中のユーザー以外の編集ページには遷移できない
    if @user.id == current_user.id
      render :edit
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    user_id = params[:user_id]
    @user = User.find(user_id)
    if params[:order_sort] ==  "0"
      @questions = Question.where(user_id: @user.id).page(params[:page]).per(10)
    elsif params[:order_sort] == "1"
      comments = Comment.where(user_id: @user.id).pluck(:question_id)
      @questions = Question.find(comments)
      @questions = Kaminari.paginate_array(@questions).page(params[:page])
    else
      bookmarks = Bookmark.where(user_id: @user.id).pluck(:question_id)
      @questions = Question.find(bookmarks)
      @questions = Kaminari.paginate_array(@questions).page(params[:page])
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :word, :introduction, :profile_image, :point)
    # profile_image_idとしないように注意
  end
end
