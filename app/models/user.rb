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

 def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg') #初期設定の画像の指定
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg') #上の記述に名前をつけている
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
 end






   #has_many_attached :image
  #1:Nで(複数枚画像投稿)で関連付け(アソシエーション)するという宣言

  # attachment :image
end
