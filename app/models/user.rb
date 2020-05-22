class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books
  has_many :favorites
  has_many :book_comments
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #フォロワー取得
  has_many :following_user, through: :follower, source: :followed #自分と自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower #自分をフォローしている人
  attachment :profile_image, destroy: false

  def follow(user_id) #ユザーをフォローする
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id) #ユザーのフォローを外す
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user) #フォローしていればtrueを返す
    following_user.include?(user)
  end

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: { maximum: 50 }
end
