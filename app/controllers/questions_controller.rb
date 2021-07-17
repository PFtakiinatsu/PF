class QuestionsController < ApplicationController
  #ログイン済みユーザーにのみアクセスを許可
  before_action :authenticate_user!

  def new
    @question = Question.new
  end

  def create
    question = Question.new(question_params)
    question.user_id = current_user.id
    question.save
    redirect_to question_path(question.id)
  end

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    # @best_answerにベストアンサーコメントを定義
    if @question.best_answer_id != nil
      @best_answer = Comment.find(@question.best_answer_id)
    end
    # @commentsはベストアンサー以外のコメント
    @comments = Comment.where(question_id: @question.id).where.not(id: @question.best_answer_id)
    @comment = Comment.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    question = Question.find(params[:id])
    question.update(question_params)
    redirect_to question_path(question.id)
    if question.best_answer_id
      question.update(is_solved: true)
    end
  end

  def search
    @questions = Question.search(params[:search])
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    redirect_to questions_path
  end

  def question_params
    params.require(:question).permit(:title, :body, :image, :user_id, :status, :subject, :point, :best_answer_id, :is_solved)
  end
end
