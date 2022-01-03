class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :image, ImageUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :instagrams
         has_many :instagrams, dependent: :destroy

         has_many :likes, dependent: :destroy
         has_many :liked_instagrams, through: :likes, source: :instagram
          def already_liked?(instagram)
            self.likes.exists?(instagram_id: instagram.id)
          end

          has_many :comments, dependent: :destroy
          
          has_many :messages, dependent: :destroy
          has_many :entries, dependent: :destroy
      
end
