class Question < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :comments, dependent: :destroy
end
