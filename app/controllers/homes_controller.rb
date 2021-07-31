# frozen_string_literal: true

class HomesController < ApplicationController
  def top
    @questions = Question.all.page(params[:page]).per(10)
    @unsolved_questions = Question.where(is_solved: false).page(params[:page]).per(10)
    @solved_questions = Question.where(is_solved: true).page(params[:page]).per(10)
    # ユーザーを保持しているポイント順に並び替え
    @users = User.all.order(point: :desc)
  end

  def about; end
end
