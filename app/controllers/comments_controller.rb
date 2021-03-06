# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    question = Question.find(params[:question_id])
    @comment = current_user.comments.new(comment_params)
    @comment.question_id = question.id
    @question = Question.find(params[:question_id])
    @comments = Comment.where(question_id: @question.id).where.not(id: @question.best_answer_id)
    @comments_amount = Comment.where(question_id: @question.id).where.not(id: @question.best_answer_id).count
    if @comment.save
      redirect_to question_path(params[:question_id])
    else
      render 'questions/show'
    end
  end

  def destroy
    comment = Comment.find_by(params[:id])
    comment.destroy
    redirect_to question_path(comment.question_id)
  end

  def comment_params
    params.require(:comment).permit(:body, :question_id, :image)
  end
end
