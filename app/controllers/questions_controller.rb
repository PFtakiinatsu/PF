# frozen_string_literal: true

class QuestionsController < ApplicationController
  # ログイン済みユーザーにのみアクセスを許可
  before_action :authenticate_user!, only: %i[edit update new]

  def new
    @question = Question.new
    @user = current_user
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    @user = current_user
    if @question.save
      user_point = current_user.point
      point_sum = user_point - @question.point
      @user.update(point: point_sum)
      redirect_to question_path(@question.id)
    else
      render :new
    end
  end

  def index
    # gem "kaminari"を使用　ペジネーションをつけたいデータに.page(params[:page])を追加
    # perで表示件数を変える（デフォルトは25件）
    @questions = case params[:order_sort]
                 when 'all'
                   Question.all.page(params[:page]).per(10)
                 when 'unsolved'
                   Question.where(is_solved: false).page(params[:page]).per(10)
                 else
                   Question.where(is_solved: true).page(params[:page]).per(10)
                 end
  end

  def show
    @question = Question.find(params[:id])
    # @best_answerにベストアンサーコメントを定義
    if @question.best_answer_id
      @best_answer = Comment.find(@question.best_answer_id)
    end
    # @commentsはベストアンサー以外のコメント
    @comments = Comment.where(question_id: @question.id).where.not(id: @question.best_answer_id)
    @comment = Comment.new
    @comments_amount = Comment.where(question_id: @question.id).where.not(id: @question.best_answer_id).count
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    question = Question.find(params[:id])
    question.update(question_params)
    if question.best_answer_id
      # best_answer_idにquestionのbest_answer_idを代入
      best_answer_id = params[:question][:best_answer_id]
      # best_answer_user_idはベストアンサーに選ばれたユーザーのID
      best_answer_user_id = Comment.find_by(id: best_answer_id).user_id
      # ベストアンサーに選ばれたユーザーのポイントを更新
      User.where(id: best_answer_user_id).update(point: question.point)
      question.update(is_solved: true)
    end
    redirect_to question_path(question.id)
  end

  def search
    @questions = Question.search(params[:search]).page(params[:page]).per(10)
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    redirect_to root_path
  end

  def question_params
    params.require(:question).permit(:title, :body, :image, :user_id, :status, :subject, :point, :best_answer_id,
                                     :is_solved)
  end
end
