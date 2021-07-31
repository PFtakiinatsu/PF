# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :body, presence: true
end
