class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @questions = Question.where(user_id: @user.id)
    bookmarks = Bookmark.where(user_id: current_user.id).pluck(:question_id)
    @bookmark_lists = Question.find(bookmarks)
    comments = Comment.where(user_id: current_user.id).pluck(:question_id)
    @answered_questions = Question.find(comments)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def index
    user_id = params[:user_id]
    @user = User.find(user_id)
    if params[:order_sort] ==  "0"
      @questions = Question.where(user_id: @user.id).page(params[:page]).per(10)
    elsif params[:order_sort] == "1"
      comments = Comment.where(user_id: @user.id).pluck(:question_id)
      @questions = Question.find(comments)
      @questions_amount = Question.find(comments).count
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
