class UserFavorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :favorite_animal
end
