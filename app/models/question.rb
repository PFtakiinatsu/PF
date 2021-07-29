class Question < ApplicationRecord
  # 質問を作成日時が新しい順に並び替える
  default_scope -> { order(created_at: :desc) }

  belongs_to :user
  attachment :image
  has_many :comments, dependent: :destroy #質問が削除されたらコメントも削除
  has_many :bookmarks, dependent: :destroy #質問が削除されたらブックマークも削除

  validates :title, presence: true
  validates :body, presence: true

  def bookmarked_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  enum subject: {
    国語:0,数学:1,理科:2,社会:3,英語:4
  }
  enum status: {
    解き方が全く分からない:0,途中まではできたが、詰まってしまった:1,答えを出したが、解答と合っていない:2,自分の解答が合っているか確認したい:3,解説に不明点がある:4,その他:5
  }

  def self.search(search)
    if search
      Question.where(["body LIKE ?", "%#{search}%"])
    else
      Question.all
    end
  end


end
