class BookmarksController < ApplicationController
  before_action :authenticate_user!,only: [:create, :destroy]

  def create
    @question = Question.find(params[:question_id])
    bookmark = current_user.bookmarks.new(question_id: @question.id)
    bookmark.save
  end

  def destroy
    @question = Question.find(params[:question_id])
    bookmark = current_user.bookmarks.find_by(question_id: @question.id)
    bookmark.destroy
  end
end
