class User < ActiveRecord::Base
  has_many :user_faves
  has_many :fave_animals, through: :user_faves
end
