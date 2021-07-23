class HomesController < ApplicationController
  def top
    @questions = Question.all
    # ユーザーを保持しているポイント順に並び替え
    @users = User.all.order(point: :desc)
  end

  def about
  end
end
