class UserFave < ActiveRecord::Base
  belongs_to :user
  belongs_to :fave_animal 
end
