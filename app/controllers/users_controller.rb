class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @questions = Question.where(user_id: @user.id).page(params[:page]).per(10)
    bookmarks = Bookmark.where(user_id: current_user.id).pluck(:question_id)
    @bookmark_lists = Question.find(bookmarks)
    @bookmark_lists = Kaminari.paginate_array(@bookmark_lists.first(10)).page(params[:page])
    comments = Comment.where(user_id: current_user.id).pluck(:question_id)
    @answered_questions = Question.find(comments)
    @answered_questions = Kaminari.paginate_array(@answered_questions.first(10)).page(params[:page])
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
    params.require(:user).permit(:name, :word, :introduction, :profile_image, :point)
    # profile_image_idとしないように注意
  end
end
