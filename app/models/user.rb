class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


   validates :name, uniqueness: true, presence: true,length:  {in: 2..20}
   validates :introduction,length: { maximum: 50}

  has_many :books, dependent: :destroy

  has_one_attached :profile_image
  #1:1で(単数枚画像投稿)で関連付け(アソシエーション)するという宣言

   #has_many_attached :image
  #1:Nで(複数枚画像投稿)で関連付け(アソシエーション)するという宣言

  # attachment :image
end
