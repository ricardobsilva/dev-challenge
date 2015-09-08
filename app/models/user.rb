class User < ActiveRecord::Base
  GENRE = ["masculino","feminino"]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         mount_uploader :image, AvatarUploader

  has_many :messages       
  has_many :friends , through: :messages, source: :firend

  has_many :friendships
  has_many :friends , through: :friendships, source: :friend
end
