class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :name, presence: true,length:  {in: 2..20}
   validates :introduction,length: { maximum: 50}

  has_many :books, dependent: :destroy
  has_one_attached :image

  # attachment :image
end
