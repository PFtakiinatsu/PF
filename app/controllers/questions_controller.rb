class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    question = Question.new(question_params)
    question.save
    redirect_to question_path(question.id)
  end

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    question = Question.find(params[:id])
    question.update(question_params)
    redirect_to question_path(question.id)
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    redirect_to questions_path
  end

  def question_params
    params.require(:question).permit(:title, :body, :image)
  end
end
