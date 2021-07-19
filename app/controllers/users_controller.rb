class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @questions = Question.where(user_id: @user.id)
    bookmarks = Bookmark.where(user_id: current_user.id).pluck(:question_id)
    @bookmark_list = Question.find(bookmarks)
    comments = Comment.where(user_id: current_user.id).pluck(:question_id)
    @answered_question = Question.find(comments)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :goal, :introduction, :profile_image)
    # profile_image_idとしないように注意
  end
end
