class CommentsController < ApplicationController
  def create
    question = Question.find(params[:question_id])
    comment = current_user.comments.new(comment_params)
    comment.question_id = question.id
    comment.save
    redirect_to question_path(question)
  end

  def destroy
    Comment.find_by(id: params[:id], question_id: params[:question_id]).destroy
    redirect_to question_path(params[:question_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
