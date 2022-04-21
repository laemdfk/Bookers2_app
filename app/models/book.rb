class Book < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
	validates :body, presence: true,
	                 length: { maximum: 200}

# 	attachment :profile_image
#user側のprofile_imageを参照させる
end
