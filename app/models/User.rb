class User < ActiveRecord::Base
  has_many :user_favorites
  has_many :favorite_animals, through: :user_favorites
end
