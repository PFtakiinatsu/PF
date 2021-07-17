class BookmarksController < ApplicationController
  def create
    question = Question.find(params[:question_id])
 #質問の投稿者以外がお気に入り登録できる
      bookmark = current_user.bookmarks.new(question_id: question.id)
      bookmark.save
      redirect_to question_path(params[:question_id])
  end

  def destroy
    question = Question.find(params[:question_id])
    bookmark = current_user.bookmarks.find_by(question_id: question.id)
    bookmark.destroy
    redirect_to question_path(params[:question_id])
  end
end
