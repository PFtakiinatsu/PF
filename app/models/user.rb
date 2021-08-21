# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true, length: { maximum: 20 }
  # 大文字と小文字を区別するuniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 300 }, uniqueness: { case_sensitive: false }
  # 大文字と小文字を区別するuniqueness: { case_sensitive: false }
  validates :introduction, length: { maximum: 300 }

  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  attachment :profile_image
end
